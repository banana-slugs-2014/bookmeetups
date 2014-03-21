class UserBooksController < ApplicationController
  def create
    user = User.find(params[:user_id])
    book = Book.find(params[:book_id])
    user.books << book
    redirect_to book_path(book)
  end
end
