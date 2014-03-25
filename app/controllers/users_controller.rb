class UsersController < ApplicationController
  before_filter :redirect_unless_logged_in, :except => [:new, :create, :landing]
  before_filter :redirect_unless_authorized, :only => [:edit, :update, :destroy]
  before_filter :redirect_unless_form_filled, :only => [:update, :create]
  before_filter :redirect_without_valid_zip, :only => [:update, :create]

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    new_user = UserBuilder.new(params[:user]).build
    location = LocationBuilder.new(params[:zip]).build
    location.users << new_user
    if new_user.save
      session[:id] = new_user.id
      redirect_to(user_path(new_user))
    else
      redirect_to(root_path, :flash => {:error => "Invalid sign up"})
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_favorite_books_path(@user)
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
    location = Location.where(:city => params[:user][:city], :state => params[:user][:state], :zip => params[:user][:zip]).first_or_create
    @user.travel_distance =  params[:user][:travel_distance]
    @user.save
    @user.update_attribute(:location, location)
    redirect_to(user_path(@user))
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to(root_path)
  end

  def landing
    render :landing
  end

end
