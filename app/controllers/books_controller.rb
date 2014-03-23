class BooksController < ApplicationController

  def index
    @books = Book.all
    render :partial => "index", locals: { books: @books }
  end

  def show
    @book = Book.find(params[:id])
    render :partial => "show", locals: { book: @book, user_id: current_user.id }
  end

  def create
    # p params[:users_books][:add]
  end

end