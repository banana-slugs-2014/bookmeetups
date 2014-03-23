class BooksController < ApplicationController

  def index
    @books = Book.all
    render :partial => "index", locals: { books: @books }
  end

  def show
    @book = Book.find(params[:id])
    render :partial => "show", locals: { book: @book }
  end

  def create
  end

end