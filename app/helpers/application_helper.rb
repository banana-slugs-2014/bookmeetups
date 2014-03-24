module ApplicationHelper

  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:id]) if session[:id]
  end

  def first_button_text
    if logged_in?
      "Log Out"
    else
      "Log In"
    end
  end

  def second_button_text
    logged_in? ? "Home" : "Sign Up"
  end

  def books_in_common_with(user)
    books = []
    user.books.each do |book|
      books << book if current_user.books.include?(book)
    end
    books
  end

  def other_books_of(user)
    books = []
    user.books.each do |book|
      books << book unless current_user.books.include?(book)
    end
    books
  end

end
