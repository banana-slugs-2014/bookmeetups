class UsersController < ActionController::Base

  def new
    @user = User.new
  end

  def create
    new_user = User.new do |user|
      user.username = params[:user][:username]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.email = params[:user][:email]
    end
    new_user.save
    redirect_to(root_path)
  end

end