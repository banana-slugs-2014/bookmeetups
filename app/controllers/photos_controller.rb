class PhotosController < ApplicationController
  before_filter :redirect_unless_logged_in

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    user = User.find(params[:user_id])
     @photo = Photo.new(params[:photo]) do |t|
      if params[:photo][:data]
        t.data      = params[:photo][:data].read
        t.filename  = params[:photo][:data].original_filename
        t.mime_type = params[:photo][:data].content_type
      end
    end

    if @photo.save
      user.photo = @photo
      redirect_to user_photo_path(user.id, @photo.id)
    else
      redirect_to new_user_photo_path
    end
  end

  def destroy
    user = User.find(params[:user_id])
    photo = Photo.find(params[:id])
    if user.photo.nil?
      photo.destroy
    else
      user.photo.destroy
    end
    redirect_to(user)
  end

  def serve
    @photo = Photo.find(params[:id])
    send_data(@photo.data, :type => @photo.mime_type, :filename => "#{@photo.name}.jpg", :disposition => "inline")
  end
end