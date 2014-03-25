class BooksController < ApplicationController
  before_filter :redirect_unless_logged_in

  def index
    @books = Book.all
    render "index", layout: true
  end

  def show
    @book = Book.find(params[:id])
    @selected_book = ((current_user.books.include? @book) ? true : false)
    @nearby_friends = current_user.friends(@book)
    @distant_friends = @book.users - [current_user] - @nearby_friends
    render "show", layout: true
  end

  def create
  end

end