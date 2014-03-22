class MeetupsController < ApplicationController
  def index
    #show the meetups for the current user
    user = current_user
    @meetups = user.meetups
  end

  def create
    #make a new meetup, add the 2 users, and show the new message form
    @meetup = Meetup.create
    current_user.meetups << meetup
    recipient = params[:user_id]
    recipient.meetups << meetup

    #create a new message for the meetup
    render  :partial => 'new_message',
            :locals =>{
              meetup: @meetup,
              message: Message.new
            }
  end

  def show
    #show the messages for a given meetup
    meetup = Meetup.where(id: params[:id])
    @messages = meetup.messages
  end

  def update
    #leave for now. will want to update the date and such of a meetup, should we decide to use that.
  end

end