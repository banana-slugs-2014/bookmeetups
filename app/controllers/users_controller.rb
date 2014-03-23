class UsersController < ApplicationController
  before_filter :redirect_unless_logged_in, :except => [:new, :create]

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    redirect_to(root_path) && return unless params[:user]
    new_user = User.new do |user|
      user.username = params[:user][:username]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.email = params[:user][:email]
    end
    set_location(new_user)
    if new_user.save
      session[:id] = new_user.id
      redirect_to(user_path(new_user))
    else
      redirect_to(root_path)
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_books_path(@user)
    end
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

  private
  def set_location(user)
    location = Location.find_or_create_by_zip_and_city_and_state(params[:zip], params[:city], params[:state])
    user.location = location
  end
end
