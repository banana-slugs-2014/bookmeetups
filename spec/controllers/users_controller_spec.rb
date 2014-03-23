require 'spec_helper'

describe UsersController do
  let(:my_location) { FactoryGirl.create :location }
  let(:my_user) { FactoryGirl.create :user, location: my_location }
  let(:attribs) { FactoryGirl.attributes_for :user_with_location }

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

      xit "should set the user location" do
        context "with an existing location" do
          xit "should set the user location by zip code" do
          end

          xit "sohuld not increase location count" do
          end
        end

        context "with a new location" do
          xit "should create a new location" do
            context "with valid attributes" do
              xit "should increase location count" do
              end

              xit "should set the user location to the new location" do
              end
            end

            context "with invalid attributes" do
              xit "should not increase location count" do
              end

              xit "should re-render the form with errors" do
              end
            end
          end

        end
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
    before(:each) { request.session[:id] = my_user.id }

    it "should be a success" do
      get :show, id: my_user.id
      expect(response).to be_success
    end

    it "should get the correct user" do
      get :show, id: my_user.id
      expect(assigns(:user)).to eq(User.find(my_user.id))
    end
  end

  context '#index' do
    before(:each) { request.session[:id] = my_user.id }

    it "should be a success" do
      get :index
      expect(response).to be_success
    end

    it "should list all users" do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  context '#edit' do
    before(:each) { request.session[:id] = my_user.id }


    it "should be a success" do
      get :edit, id: my_user.id
      expect(response).to be_success
    end

    it "should get the correct user" do
      get :edit, id: my_user.id
      expect(assigns(:user)).to eq(my_user)
    end
  end

  context '#update' do
    before(:each) { request.session[:id] = my_user.id }
    let(:location_attribs) {attributes_for :location}

    context "with valid attributes" do
      it "should be a redirect" do
        put :update, { id: my_user.id, :user => location_attribs }
        expect(response).to be_redirect
      end
    end
  end

  context '#destroy' do
    let!(:delete_user) { FactoryGirl.create :user }
    before(:each) { request.session[:id] = delete_user.id }

    it "should be redirect" do
      delete :destroy, id: delete_user.id
      expect(response).to be_redirect
    end

    it "should get correct user" do
      delete :destroy, id: delete_user.id
      expect(assigns(:user)).to eq(delete_user)
    end

    it "should decrease the user count" do
      expect {
        delete :destroy, id: delete_user.id
        }.to change { User.count }.by(-1)
    end
  end
end