require 'spec_helper'

describe MeetupsController do
  let!(:new_meetup) { Meetup.create(id: 1) }
  let!(:my_user){ create :user}
  let!(:other_user) {create :user}
  let!(:meetup_book) {create :book}
  before(:each) { request.session[:id] = my_user.id }


  context "#index" do
    before(:each) { request.session[:id] = my_user.id }

    it "should be success" do
      get :index, :user_id => my_user.id
      expect(response).to be_ok
    end

    it "should assign all of a user's meetups" do
      my_user.meetups << new_meetup
      get :index, :user_id => my_user.id
      expect(assigns(:meetups)).to eq([Meetup.find(new_meetup.id)])
    end
  end

  context "#create" do
    before(:each) { request.session[:id] = my_user.id}
    it "should be success" do
      post :create, :user_id => other_user.id, :book_id => meetup_book.id
      expect(response).to be_ok
    end

    it "should create a meetup" do
      expect {
        post :create, :user_id => other_user.id, :book_id => meetup_book.id
        }.to change { Meetup.count }.by(1)
    end

    it "should assign a book to the meetup" do
      post :create, :user_id => other_user.id, :book_id => meetup_book.id
      expect(meetup_book.meetups.first.book).not_to be_nil
    end

    it "should add the meetup to the my user" do
      post :create, :user_id => other_user.id, :book_id => meetup_book.id
      expect(my_user.meetups.length).to eq(1)
    end

    it "should add the meetup to the other user" do
      post :create, :user_id => other_user.id, :book_id => meetup_book.id
      expect(other_user.meetups.length).to eq(1)
    end

    it "should have both users associated with the meetup" do
      post :create, :user_id => other_user.id, :book_id => meetup_book.id
      expect(Meetup.last.users.length).to eq(2)
    end
  end

  context "#show" do
    context 'with valid user' do
      before(:each) { request.session[:id] = my_user.id}
      it 'should assign all of the meetup messages' do
        message1 = Message.create(text: "hello")
        message2 = Message.create(text: "hello a second time")
        new_meetup.users << my_user
        new_meetup.users << other_user
        new_meetup.messages << message1
        new_meetup.messages << message2

        get :show, {:user_id => my_user.id, :id => new_meetup.id}
        expect(assigns(:messages)).to eq ([message2,message1])
      end
    end

    context 'with not logged in user' do
      before(:each) { request.session[:id] = nil}

      it "should redirect" do
        get :show, {:user_id => my_user.id, :id => new_meetup.id}
        expect(response).to be_redirect
      end
    end

    context 'with user not in the meetup' do
      let!(:unauthorized_user) { create :user }
      before(:each) { request.session[:id] = unauthorized_user.id }

      xit "should redirect back to the current user books page" do
        get :show, { :user_id => my_user.id, :id => new_meetup.id }
        expect(response).to be_redirect
      end
    end

  end
end