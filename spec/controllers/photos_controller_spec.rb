require 'spec_helper'

describe PhotosController do
  let!(:test_user) { create :user }
  let(:test_photo) { create :photo }

  context '#show' do
    it 'should be successful' do
      get :show, { :user_id => test_user.id, :id => test_photo.id }
      expect(response).to be_success
    end

    it 'should find right photo' do
      get :show, { :user_id => test_user.id, :id => test_photo.id }
      expect(assigns(:photo)).to eq(test_photo)
    end
  end

  context '#new' do
  end

  context '#create' do
    let(:attribs) { attributes_for :photo }

    it 'should be redirect' do
      post :create, { :user_id => test_user.id, :photo => attribs }
      expect(response).to be_redirect
    end

    it 'should create a new photo' do
      expect {
        post :create, { :user_id => test_user.id, :photo => attribs }
      }.to change { Photo.count }.by(1)
    end

    it 'should associate new photo with user' do
      post :create, { :user_id => test_user.id, :photo => attribs }
      expect(assigns(:photo)).to eq(test_user.photo)
    end
  end

  context '#destroy' do
  end

end