class MeetupsController < ApplicationController
  before_filter :redirect_unless_logged_in
  before_filter :redirect_unless_authorized, :only => [:index]

  def index
    @meetups = current_user.meetups.uniq
    render :index
  end

  def create
    @other_user = User.find(params[:user_id])
    book = Book.find(params[:book_id])
    book.meetups.each do |existing_meetup|
      @meetup = existing_meetup if (existing_meetup.users.include?(current_user ) &&
                                    existing_meetup.users.include?(User.find(params[:user_id])))
    end
    if @meetup.nil?
      @meetup = Meetup.create
      book.meetups << @meetup
      current_user.meetups << @meetup
      @other_user.meetups << @meetup
    end
    @messages = @meetup.messages
    render  :"show"
  end

  def show
    @meetup = Meetup.where(id: params[:id]).first
    (redirect_to user_favorite_books_path(session[:id]) && return) unless @meetup.users.include?(current_user)
    if current_user.id == params[:user_id].to_i
      @other_user = (@meetup.users - [current_user]).first
      @messages = @meetup.messages.order("created_at DESC")
      @meetup.mark_read(current_user)
      render :show
    else
      render :"shared/unauthorized", :layout => true
    end
  end
end
