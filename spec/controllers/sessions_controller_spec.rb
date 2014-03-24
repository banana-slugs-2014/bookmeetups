require 'spec_helper'

describe SessionsController do
  let(:credentials) { {username: 'bob', password: 'test'} }
  let!(:existing_user) do
    User.create do |user|
      user.username = credentials[:username]
      user.password = credentials[:password]
      user.email = 'test@glados.com'
      user.location_id = 1
    end
  end

  context '#login' do
    it "should be successful" do
      get :new
      expect(response).to be_success
    end

    it "should create a login form" do
      get :new
      expect(assigns(:login)).to be_a_new(User)
    end
  end

  context '#create' do
    context 'with valid params' do
      it 'should be redirect' do
        post :create, { user: credentials }
        expect(response).to be_redirect
      end

      it 'should create a new session' do
        post :create, { user: credentials }
        session[:id].should == existing_user.id
      end
    end

    context 'with all invalid params' do
      let(:invalid_cred) { {username: 'bobert', password: 'nottest'} }

      it 'should be redirect' do
        post :create, { user: invalid_cred }
        expect(response).to be_redirect
      end

      it 'should not find user' do
        post :create, { user: invalid_cred }
        expect(assigns(:user)).to be_nil
      end

      it 'should not create a new session' do
        post :create, { user: invalid_cred }
        session[:id].should be_nil
      end
    end

    context 'with some invalid params' do
      let(:invalid_cred) { {username: 'bob', password: 'nottest'} }

      it 'should be redirect' do
        post :create, { user: invalid_cred }
        expect(response).to be_redirect
      end

      it 'should find user' do
        post :create, { user: invalid_cred }
        expect(assigns(:user)).to_not be_nil
      end

      it 'should not create a new session' do
        post :create, { user: invalid_cred }
        session[:id].should be_nil
      end
    end
  end

  context '#destroy' do
    before(:each) { request.session[:id] = existing_user.id }

    it 'should be redirect' do
      delete :destroy, id: existing_user.id
      expect(response).to be_redirect
    end

    it "should delete current session" do
      delete :destroy, id: existing_user.id
      session[:id].should be_nil
    end
  end
end