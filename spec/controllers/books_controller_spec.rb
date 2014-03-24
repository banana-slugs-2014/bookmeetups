require 'spec_helper'

describe BooksController do
  let!(:my_user) { create :user }
  let(:my_book) { create :book }
  let(:attribs) { attributes_for :book }
  let(:location) { create :location }
  before(:each) { request.session[:id] = my_user.id }

  context '#create' do
    context "with valid attributes" do
      xit "should redirect" do
        post :create, book: attribs
        expect(response).to be_redirect
      end
    end
  end

  context '#show' do
    it "should be ok" do
      # User.any_instance.stub(:friends).and_return([])
      my_user.location = location.id
      get :show, id: my_book.id
      # p * 100
      response.status.should eql('200 OK')
      # # expect(response).to be_success
    end

    it "should get the correct book" do
      get :show, id: my_book.id
      expect(assigns(:book)).to eq(Book.find(my_book.id))
    end
  end

  context '#index' do
    it "should be ok" do
      get :index
      expect(response).to be_success
    end

    it "should list all current books" do
      get :index
      expect(assigns(:books)).to eq(Book.all)
    end
  end
end

