class BooksController < ActionController::Base

  def show
    @book = Book.find(params[:id])
  end

end