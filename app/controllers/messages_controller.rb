class MessagesController < ApplicationController
  # def new
  #   meetup = params[:meetup_id]
  #   @message = Message.new
  # end

  def create
    #make a new message for the meetup.
    meetup = Meetup.find(params[:meetup_id])
    message = Message.new(params[:message])
    if @message.valid?
      meetup.messages << message
    end
  end


end