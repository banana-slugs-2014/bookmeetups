class PhotosController < ApplicationController
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
  end
end