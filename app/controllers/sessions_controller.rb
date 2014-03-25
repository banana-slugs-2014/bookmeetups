class SessionsController < ApplicationController

  def new
    @login = User.new
    render :login, :layout => true
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user.nil? || !valid_login?
      redirect_to(new_session_path, :flash => {:error => "Invalid login"})
    else
      session[:id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def destroy
    session.clear
    redirect_to(new_user_path)
  end

  private
  def valid_login?
    @user.authenticate(params[:user][:password])
  end

end