class UsersController < ApplicationController
  before_filter :redirect_unless_logged_in, :except => [:new, :create]

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  # there is a ton of visual bloat in here.  15 lines.  It just makes me wince
  # looking at it.  There are things to do to tighten it up.  I think this
  # could be 5 lines or so.  Jamie and i have talked about this a bit and she's
  # working on it presently.  But you should just not want to commit this.
  def create
    redirect_to(root_path) && return unless params[:user]
    new_user = User.new do |user|
      user.username = params[:user][:username]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.email = params[:user][:email]
    end
   location = Location.where(:city => params[:city], :state => params[:state], :zip => params[:zip]).first_or_create
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
    location = Location.where(:city => params[:user][:city], :state => params[:user][:state], :zip => params[:user][:zip]).first_or_create
    @user.update_attribute(:location, location)
    redirect_to(user_path(@user))
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to(root_path)
  end

end
