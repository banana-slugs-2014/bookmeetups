class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
  end

  def new
  end

  def create
    user = User.find(params[:user_id])
    @photo = Photo.create do |p|
      p.name = params[:photo][:name]
      p.data = params[:photo][:data]
      p.filename = params[:photo][:filename]
      p.mime_type = params[:photo][:mime_type]
    end
    user.photo = @photo
    redirect_to user_photo_path(user.id, @photo.id)
  end

  def destroy
  end
end