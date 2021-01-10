class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    before_action :require_no_session, only: [:new, :create]

    def index
        #sort by friends with matching restaurants
        @friends = current_user.friends
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = User.last.id
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def show
        @user = User.friendly.find_by_friendly_id(params[:id])

    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :email, :password_confirmation)
    end
end
