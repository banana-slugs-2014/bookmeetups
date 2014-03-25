class FavoriteBooksController < ApplicationController
  before_filter :redirect_unless_logged_in

  def create
    user = User.find(params[:user_id])
    book = Book.find(params[:book_id])
    user.books << book if !user.books.include? (book)
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.books.delete(book)
    redirect_to user_favorite_books_path
  end

  def index
    @user = User.find(params[:user_id])
    render "users/books_index", locals: { user: @user }, layout: true
  end
end