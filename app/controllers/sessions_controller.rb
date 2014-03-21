class SessionsController < ApplicationController

  def new
    @login = User.new
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user.nil? || invalid_login?
      redirect_to(new_session_path)
    else
      session[:id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.where(id: params[:id]).first
    (redirect_to(root_path) && return) if @user.nil?
    if authorized?
      @user.destroy
      session.clear
      redirect_to(root_path)
    else
      redirect_to user_path(session[:id])
    end
  end

  private
    def invalid_login?
      !@user.authenticate(params[:user][:password])
    end

    def authorized?
      session[:id] == @user.id
    end

end