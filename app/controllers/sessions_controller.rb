class SessionsController < ApplicationController

  def new
    @login = User.new
    render :partial => "login", locals: { login: @login }
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
    session.clear
    redirect_to(root_path)
  end

  private
    def invalid_login?
      !@user.authenticate(params[:user][:password])

    end

end