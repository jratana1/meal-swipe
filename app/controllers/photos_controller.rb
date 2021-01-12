class PhotosController < ApplicationController
    def index
        @photos = current_user.photos
    end

    def show
        @photo = Photo.find_by_id(params[:id])
    end

    def new
    end

    def create
    end

    def destroy
        #check photo belongs to current user
        #hide delete button on other users pages.
        user = User.find_by_id(params[:user_id])
        photo = Photo.find_by_id(params[:id])
        photo.destroy
        redirect_to user_photos_path(user)
    end
end
