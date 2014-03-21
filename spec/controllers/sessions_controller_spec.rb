require 'spec_helper'

describe SessionsController do
  let(:credentials) { {username: 'bob', password: 'test'} }
  let!(:existing_user) do
    User.create do |user|
      user.username = credentials[:username]
      user.password = credentials[:password]
      user.email = 'test@glados.com'
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
  end
end