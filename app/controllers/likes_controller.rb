class LikesController < ApplicationController
    def create
        like = Like.create(like_params)
        flash[:notice] = "You now like #{like.restaurant.name}."
        redirect_to restaurant_path(like.restaurant)
    end

    def destroy
      like = current_user.likes.find_by(restaurant_id: params[:like][:restaurant_id])

      if like != nil     
          flash[:notice] = "You have unliked #{like.restaurant.name}."
          like.destroy
      else
          flash[:notice] = "You already don't like that restaurant."      
      end
      redirect_to restaurants_path
    end

    private

    def like_params
        params.require(:like).permit(:restaurant_id, :user_id)
    end
end
