class MeetupsController < ApplicationController
  def index
    @meetups = current_user.meetups
    render partial: "index", locals: { meetups: @meetups }
  end

  def create
    book =  Book.find(params[:book_id])
    @meetup = Meetup.create
    book.meetups << @meetup
    current_user = User.find(session[:id])
    current_user.meetups << @meetup
    recipient = User.find(params[:user_id])
    recipient.meetups << @meetup

    render  :partial => 'new_message',
            :locals =>{
              meetup: @meetup,
              message: Message.new
            }
  end

  def show
    (redirect_to root_path && return) unless session[:id]
    meetup = Meetup.where(id: params[:id]).first
    current_user = User.where(id: params[:user_id]).first
    #(redirect user_books_path(current_user) && return) unless meetup.users.include?(current_user)
    @messages = meetup.messages
    render :partial => 'show', :locals => {meetup: meetup}
  end

end
