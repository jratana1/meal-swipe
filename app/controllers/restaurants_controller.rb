class RestaurantsController < ApplicationController
    def index
        if params[:user_id]
            @restaurants = User.friendly.find_by_friendly_id(params[:user_id]).liked_restaurants
            # Restaurant.joins(:likes).group(:id).order("id asc")
        else
            @restaurants = Restaurant.all.order("name ASC")
        end
    end

    def show
        @restaurant = Restaurant.friendly.find_by_friendly_id(params[:id])
    end

    def new
        @restaurant = Restaurant.new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end
end
