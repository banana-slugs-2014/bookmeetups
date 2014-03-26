class PhotosController < ApplicationController
  before_filter :redirect_unless_logged_in, :except => :default

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    render partial: "photos/show", locals: { user: @user, photo: @photo }
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    user = User.find(params[:user_id])
    @photo = PhotoBuilder.new(params[:photo]).build
    if @photo.save
      user.photo.destroy unless user.photo.nil?
      user.photo = @photo
      redirect_to user_path(user.id)
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
    photo = Photo.find(params[:id])
    send_data( photo.data,
      :type => photo.mime_type,
      :filename => "#{photo.name}.jpg",
      :disposition => "inline" )
  end
end