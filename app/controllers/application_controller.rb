class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    !!session[:id]
  end

  def redirect_unless_logged_in
    redirect_to(root_path, :flash =>
      {:error => "You must be logged in to do that"}) unless logged_in?
  end

  def current_user
    User.find(session[:id]) if session[:id]
  end

  def authorized?(user_id)
    session[:id] == user_id
  end

  def redirect_unless_authorized(user_id)
    (redirect_to(user_path(session[:id])) && return) unless authorized?(user_id)
  end

end
