require 'spec_helper'

describe UserBooksController do
  let!(:my_user) { create :user }
  let!(:my_book) { create :book }

  context "#create" do
    it "should redirect" do
      post :create, user_id: my_user, book_id: my_book, user_book: {}
      expect(response).to be_redirect
    end
  end

end