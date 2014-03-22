require 'spec_helper'

describe PhotosController do
  let!(:test_user) { create :user }
  let!(:test_photo) { create :photo }
  before(:each) { test_user.photo = test_photo }

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

  context '#create' do
  end

  context '#destroy' do
  end

end