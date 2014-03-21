class UserBooksController < ApplicationController
  def create
    user = User.find(params[:user_id])
    book = Book.find_or_create_by_isbn(params[:isbn])
    user.books << book
    redirect_to book_path(book)
  end
end
