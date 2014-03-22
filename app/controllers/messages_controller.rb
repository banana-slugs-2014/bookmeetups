class MessagesController < ApplicationController
  def create
    meetup = Meetup.find(params[:meetup_id])
    message = Message.new(params[:message])
    if @message.valid?
      meetup.messages << message
    end
  end
end
