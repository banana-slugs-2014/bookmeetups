require 'spec_helper'

describe PhotosController do
  let!(:test_user) { create :user }
  let(:test_photo) { create :photo }
  before(:each) { request.session[:id] = test_user.id }

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
    it 'should be success' do
      get :new, { :user_id => test_user.id }
      expect(response).to be_success
    end

    it 'should create an empty photo template' do
      get :new, { :user_id => test_user.id }
      expect(assigns(:photo)).to be_a_new(Photo)
    end
  end

  context '#create' do
    let(:photo_data) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/upload_test.jpg", "image/jpg") }

    context 'with valid attributes' do
      it 'should be redirect' do
        post :create, { :user_id => test_user.id, :photo => {name: 'test', data: photo_data} }
        expect(response).to be_redirect
      end

      it 'should create a new photo' do
        expect {
          post :create, { :user_id => test_user.id, :photo => {name: 'test', data: photo_data} }
        }.to change { Photo.count }.by(1)
      end

      it 'should associate new photo with user' do
        post :create, { :user_id => test_user.id, :photo => {name: 'test', data: photo_data} }
        expect(assigns(:photo)).to eq(test_user.photo)
      end
    end
  end

  context '#destroy' do
    let!(:existing_photo) { create :photo }

    it 'should be redirect' do
      delete :destroy, { :user_id => test_user.id, :id => existing_photo.id }
      expect(response).to be_redirect
    end

    it 'should destroy a photo' do
      expect {
        delete :destroy, { :user_id => test_user.id, :id => existing_photo.id }
      }.to change { Photo.count }.by(-1)
    end
  end

  context '#serve' do
    before(:each) {
      expect(controller).to receive(:send_data).once {controller.render text: "photo_data" }
    }

    it "should be successful" do
      get :serve, { user_id: test_user.id, id: test_photo.id }
    end
  end

end