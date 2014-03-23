class MessagesController < ApplicationController
  def new
    @meetup = Meetup.where(id: params[:meetup_id]).first
    @message = Message.new
    render partial: 'new', locals: { meetup: @meetup, message: @message}
  end

  def create
    meetup = Meetup.find(params[:meetup_id])
    message = Message.new(params[:text])
    if @message.valid?
      meetup.messages << message
    end
  end
end
