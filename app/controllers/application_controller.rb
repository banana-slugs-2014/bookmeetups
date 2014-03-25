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
    id = params[:id] || params[:user_id]
    session[:id] == id.to_i
  end

  def redirect_unless_authorized
    redirect_to(user_path(session[:id]), :flash => {:error => "You are not authorized to perform this task"}) unless authorized_user?
  end

  def redirect_unless_form_filled
    redirect_to(new_user_path, :flash => {:error => "Please fill out the form"}) unless params[:user]
  end

end
