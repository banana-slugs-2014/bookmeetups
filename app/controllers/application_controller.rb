class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    !!session[:id]
  end

  def redirect_unless_logged_in
    redirect_to(root_path, :flash =>
      {:error => "You must be logged in to do that"}
      ) unless logged_in?
  end

  def current_user
    User.find(session[:id]) if session[:id]
  end

  def authorized_user?
    session[:id] == params[:id]
  end

  def redirect_unless_authorized
    redirect_to(user_path(session[:id]), :flash => {:error => "You are not authorized to perform this task"}) unless authorized_user?
  end

  def form_present?
    params[:user].empty?
  end

end
