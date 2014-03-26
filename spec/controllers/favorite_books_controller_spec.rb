require 'spec_helper'

describe FavoriteBooksController do
  let!(:my_user) { create :user }
  let!(:my_book) { create :book }
  before(:each) { request.session[:id] = my_user.id }
  before(:each) { my_user.books << my_book }


  context "#create" do
    let!(:my_book2) { create :book }

    context 'with valid params' do
      it "should redirect" do
        post :create, user_id: my_user, book_id: my_book2, favorite_book: {}
        expect(response).to be_redirect
      end

      it "should increase count of FavoriteBooks" do
        expect{
          post :create, user_id: my_user, book_id: my_book2, favorite_book: {}
        }.to change{ FavoriteBook.count }.by(1)
      end
    end

    context 'with a previously favorited book' do
      it "should be redirect" do
        post :create, user_id: my_user, book_id: my_book, favorite_book: {}
        expect(response).to be_redirect
      end

      it "should not increase FavoriteBook count" do
        expect {
          post :create, user_id: my_user, book_id: my_book, favorite_book: {}
          }.to_not change { FavoriteBook.count }
      end
    end

    context 'with missing params' do
      it "should be an error" do
        expect {
          post :create, user_id: my_user, book_id: nil, favorite_book: {}
        }.to raise_error(ActionController::RoutingError,
          'No route matches {:user_id=>"1", :book_id=>nil, :favorite_book=>{}, :controller=>"favorite_books", :action=>"create"}')
      end
    end

    context 'when not logged in' do
      before(:each) { request.session[:id] = nil }

      it "should be redirect" do
        post :create, user_id: my_user, book_id: my_book, favorite_book: {}
        expect(response).to be_redirect
      end

      it "should not change FavoriteBook count" do
        expect{
          post :create, user_id: my_user, book_id: my_book2, favorite_book: {}
        }.to_not change{ FavoriteBook.count }
      end
    end
  end

  context "#destroy" do
    it "should decrease FavoriteBook count" do
      expect {
        delete :destroy, user_id: my_user, book_id: my_book
        }.to change{ FavoriteBook.count }.by(-1)
    end

    it "should redirect" do
      delete :destroy, user_id: my_user, book_id: my_book
      expect(response).to be_redirect
    end
  end

  context "#index" do
    it "should be ok" do
      get :index, user_id: my_user
      expect(response).to be_success
    end

    it "should find the correct user" do
      get :index, user_id: my_user
      expect(assigns(:user)).to eq(my_user)
    end
  end
end