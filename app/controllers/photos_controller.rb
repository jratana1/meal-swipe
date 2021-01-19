class PhotosController < ApplicationController
    def index
        @user = User.friendly.find_by_friendly_id(params[:user_id])
        @photos = @user.photos
    end

    def show
        @photo = Photo.find_by_id(params[:id])
    end

    def new
        
        if params[:restaurant_id]
            @restaurant = Restaurant.friendly.find_by_friendly_id(params[:restaurant_id])
            @photo = Photo.new
            @photo.restaurant = @restaurant
        else    
            @photo = Photo.new
            @photo.build_restaurant
        end
    end

    def create
        @restaurant = Restaurant.find_by_name(photo_params[:restaurant_attributes][:name])
        @photo = Photo.new(user_id:current_user.id, url:photo_params[:url])

        if @restaurant
            @photo.restaurant = @restaurant
        else
            @restaurant = @photo.build_restaurant(photo_params[:restaurant_attributes])
        end
        
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
        params.require(:photo).permit(:url, restaurant_attributes: [:name, :address, :city, :state, :zip_code])
    end
end
