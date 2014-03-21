require 'spec_helper'

describe UsersController do
  let(:my_user) { FactoryGirl.create :user }
  let(:attribs) { FactoryGirl.attributes_for :user }

  context '#new' do
    it "should be a success" do
      get :new
      expect(response).to be_success
    end

    it "should create a new empty user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  context '#create' do
    context 'With valid attributes' do
      it "should be redirect" do
        post :create, user: attribs
        expect(response).to be_redirect
      end

      it "should increase user count by one" do
        expect {
          post :create, user: attribs
        }.to change { User.count }.by(1)
      end
    end

    context 'With invalid attributes' do
      it "should be redirect" do
        post :create
        expect(response).to be_redirect
      end

      it "should not increase User count" do
        expect {
          post :create
          }.to_not change { User.count }
      end
    end
  end

  context '#show' do
    it "should be a success" do
      get :show, id: my_user.id
      expect(response).to be_success
    end

    it "should get the correct user" do
      get :show, id: my_user.id
      expect(assigns(:user)).to eq(User.find(my_user.id))
    end
  end
end