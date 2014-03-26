class FavoriteBooksController < ApplicationController
  before_filter :redirect_unless_logged_in

  def create
    user = User.where(id: params[:user_id]).first
    book = Book.where(id: params[:book_id]).first
    user.books << book unless user.books.include?(book)
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