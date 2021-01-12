class PhotosController < ApplicationController
    def index
        @photos = User.friendly.find_by_friendly_id(params[:user_id]).photos
    end

    def show
        @photo = Photo.find_by_id(params[:id])
    end

    def new
    end

    def create
    end

    def destroy
        user = User.find_by_id(params[:user_id])
        photo = Photo.find_by_id(params[:id])
        if photo.user_id == user.id
        photo.destroy
        flash[:alert] = "Photo has been deleted." 
        else
        flash[:alert] = "That photo doesn't belong to you." 
        end
        redirect_to user_photos_path(user)
    end
end
