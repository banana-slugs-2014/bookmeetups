class MeetupsController < ApplicationController
  before_filter :redirect_unless_logged_in

  def index
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
    @meetup = Meetup.where(id: params[:id]).first
    (redirect_to user_books_path(session[:id]) && return) unless @meetup.users.include?(current_user)
    if current_user.id == params[:user_id].to_i
      @other_user = (@meetup.users - [current_user]).first
      @messages = @meetup.messages.order("created_at DESC")
      render :show
    else
      render :"shared/unauthorized", :layout => true
    end
  end
end
