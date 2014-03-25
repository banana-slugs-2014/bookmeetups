class MessagesController < ApplicationController
  before_filter :redirect_unless_logged_in

  def new
    @meetup = Meetup.where(id: params[:meetup_id]).first
    @message = Message.new
    render :partial => "messages/new", :locals => { message: @message, meetup: @meetup}
  end

  def create
    meetup = Meetup.find(params[:meetup_id])
    message = Message.new do |m|
      m.text = params[:message][:text]
      m.user = current_user
      m.user_id = current_user.id
    end
    if message.save
      meetup.messages << message
      other_user = meetup.other_user( current_user)
      other_user.new_unread_message
    end
    render :partial => 'messages/created_message',
           :locals => { meetup: meetup, message: message }

  end
end