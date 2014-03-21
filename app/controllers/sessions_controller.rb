class SessionsController < ApplicationController

  def new
    @login = User.new
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    redirect_to(new_session_path) && return if @user.nil?
    redirect_to(new_session_path) && return unless @user.authenticate(params[:user][:password])
    session[:id] = @user.id
    redirect_to(user_path(@user))
  end

  def destroy
  end

end