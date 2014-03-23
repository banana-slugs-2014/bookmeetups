class BooksController < ApplicationController

  def index
    @books = Book.all
    render "index", layout: true
  end

  def show
    @book = Book.find(params[:id])
    render "show", layout: true
  end

  def create
  end

end