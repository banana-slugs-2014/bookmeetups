class UsersController < ActionController::Base

  def new
    @user = User.new
  end

  def create
    redirect_to(root_path) && return unless params[:user]
    new_user = User.new do |user|
      user.username = params[:user][:username]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.email = params[:user][:email]
    end
    redirect_to(root_path) && return unless new_user.save
    redirect_to(root_path)
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    redirect_to(edit_user_path(@user)) && return unless @user.update_attributes(params[:user])
    redirect_to(user_path(@user))
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to(root_path)
  end

end
