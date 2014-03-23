class MessagesController < ApplicationController
  before_filter :redirect_unless_logged_in

  def new
    @meetup = Meetup.where(id: params[:meetup_id]).first
    @message = Message.new
    render :"messages/new", :layout => true
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
    end
    redirect_to user_meetup_path(current_user, meetup)
  end
end
