module ApplicationHelper

  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:id]) if session[:id]
  end
end
