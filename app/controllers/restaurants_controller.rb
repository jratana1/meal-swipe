class RestaurantsController < ApplicationController
    def index
        if params[:user_id]
            @restaurants = User.friendly.find_by_friendly_id(params[:user_id]).liked_restaurants
        else
            @restaurants = Restaurant.all.order("name ASC")
        end
    end

    def show
        @restaurant = Restaurant.friendly.find_by_friendly_id(params[:id])
    end

    def new
        @restaurant = Restaurant.new
        @restaurant.photos.build
        @action = params[:action]
    end

    def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.photos.build(url:restaurant_params[:photos_attributes]["0"][:url], user_id:current_user.id)
        @restaurant.image_url = @restaurant.photos.last.url
        if @restaurant.save
            flash[:alert] = "You have added a new restaurant."
            redirect_to restaurant_path(@restaurant)
        else
            render 'new'
        end
    end

    def edit  
        @restaurant = Restaurant.friendly.find_by_friendly_id(params[:id])
        @action = params[:action]
    end

    def update
        @restaurant = Restaurant.friendly.find_by_friendly_id(params[:id])
        if @restaurant.update(restaurant_params)
            flash[:alert] = "Restaurant information successfully updated."
            redirect_to restaurant_path(@restaurant)
        else
            render 'edit'
        end
    end

    def destroy
    end

    def swipe    
        if params.key?(:location)
            session[:location] = params[:location]
            results = Restaurant.api_search(params[:location])
            results.each do |restaurant|
                @rest_hash = Restaurant.yelp_hash_converter(restaurant)
                if @rest_hash[:image_url]         
                  restaurant = Restaurant.create_with(@rest_hash).find_or_create_by(yelp_id: @rest_hash[:yelp_id])
                  restaurant.photos << Photo.create_with(url:restaurant.image_url,leftswipes:0,rightswipes:0, user_id:1).find_or_create_by(url: restaurant.image_url)
                end
            end      
            @photo = Photo.swipe_photo_search(params[:location])
        elsif session[:location]        
            @photo = Photo.swipe_photo_search(session[:location])
        else        
            @photo = Photo.all.sample
        end

            if params[:swipe] == "right"
                swiper(params[:swipe], params[:photo_id])
                restaurant = Restaurant.find(@photo.restaurant_id)
                Like.create(restaurant_id:restaurant.id, user_id:session[:user_id])
                flash[:alert] = "You liked #{restaurant.name}! "
                redirect_to restaurant_path(restaurant)   
            elsif params[:swipe] == "left"
                swiper(params[:swipe], params[:photo_id])
                @photo = Photo.swipe_photo_search(session[:location])
            end  
    end

    private
    def restaurant_params
        params.require(:restaurant).permit(:name, :address, :city, :state, :zip_code, photos_attributes:[:url])
    end
end
