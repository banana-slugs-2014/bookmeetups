require 'spec_helper'

describe UserBooksController do
  let!(:my_user) { create :user }
  let!(:my_book) { create :book }
  before(:each) { request.session[:id] = my_user.id }
  before(:each) { my_user.books << my_book }


  context "#create" do
    it "should redirect" do
      post :create, user_id: my_user, book_id: my_book, user_book: {}
      expect(response).to be_redirect
    end

    it "should increase count of UserBooks" do
      expect{
        post :create, user_id: my_user, book_id: my_book  , user_book: {}
      }.to change{ UserBook.count }.by(1)
    end
  end

  context "#destroy" do
    it "should redirect" do
      expect { delete :destroy, user_id: my_user, book_id: my_book }.to change{ UserBook.count }.by(-1)
      expect(response).to be_redirect
    end


  end

end