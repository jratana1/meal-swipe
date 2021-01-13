class PhotosController < ApplicationController
    def index
        @photos = User.friendly.find_by_friendly_id(params[:user_id]).photos
    end

    def show
        #add back button to view
        @photo = Photo.find_by_id(params[:id])
    end

    def new
        @photo = Photo.new
        @photo.build_restaurant
    end

    def create
        byebug
        @photo = Photo.new(photo_params)

        if @photo.save
            flash[:alert] = "You have added a photo."
            redirect_to user_photos_path(current_user)
        else
            render 'new'
        end
    end

    def destroy
        photo = Photo.find_by_id(params[:id])

        if photo.user_id == current_user.id
            photo.destroy
            flash[:alert] = "Photo has been deleted." 
        else
            flash[:alert] = "That photo doesn't belong to you." 
        end
            redirect_to user_photos_path(current_user)
    end

    private
    def photo_params
        params.require(:photo).permit(:url, :restaurant_id)
    end
end
