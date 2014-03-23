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

end
