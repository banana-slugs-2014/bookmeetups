class MeetupsController < ApplicationController
  def index
    #show the meetups for the current user
    @meetups = current_user.meetups
    render partial: "index", locals: { meetups: @meetups }
  end

  def create
    #make a new meetup, add the 2 users, and show the new message form
    book =  Book.find(params[:book_id])
    @meetup = Meetup.create
    book.meetups << @meetup
    current_user = User.find(session[:id])
    current_user.meetups << @meetup
    recipient = User.find(params[:user_id])
    recipient.meetups << @meetup

    #create a new message for the meetup
    render  :partial => 'new_message',
            :locals =>{
              meetup: @meetup,
              message: Message.new
            }
  end

  def show
    # redirect_unless_logged_in
    (redirect_to root_path && return) unless session[:id]
    meetup = Meetup.where(id: params[:id]).first
    current_user = User.where(id: params[:user_id]).first
    #(redirect user_books_path(current_user) && return) unless meetup.users.include?(current_user)
    @messages = meetup.messages
    render :partial => 'messages/show'
  end

  def update
    #leave for now. will want to update the date and such of a meetup, should we decide to use that.
  end

end