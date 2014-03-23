class MeetupsController < ApplicationController
  def index
    (redirect_to root_path && return) unless session[:id]
    if session[:id] == params[:user_id].to_i
      @meetups = current_user.meetups
      render :index
    else
      render :"shared/unauthorized", :layout => true
    end
  end

  def create
    book =  Book.find(params[:book_id])
    @meetup = Meetup.create
    @message = Message.new
    book.meetups << @meetup
    current_user = User.find(session[:id])
    current_user.meetups << @meetup
    recipient = User.find(params[:user_id])
    recipient.meetups << @meetup
    render  :"messages/new"
  end

  def show
    (redirect_to root_path && return) unless session[:id]
    @meetup = Meetup.where(id: params[:id]).first
    current_user = User.where(id: params[:user_id]).first
    (redirect_to user_books_path(current_user) && return) unless @meetup.users.include?(current_user)
    if current_user.id == params[:user_id].to_i
      @messages = @meetup.messages
      render :show
    else
      render :"shared/unauthorized", :layout => true
    end
  end
end
