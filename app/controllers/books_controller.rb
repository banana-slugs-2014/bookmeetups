class BooksController < ApplicationController

  def index
    @books = Book.all
    render "index", layout: true
  end

  def show
    @book = Book.find(params[:id])
    if current_user.books.include? @book
      @button = true
    else
      @button = false
    end
    render "show", layout: true
  end

  def create
  end

end