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
            flash[:alert] = "Welcome, you have successfully signed up."
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def show
        @user = User.friendly.find_by_friendly_id(params[:id])
    end

    def edit
        @user = current_user
    end

	def update
        @user = User.friendly.find_by_friendly_id(params[:id])
        if skip_password_attribute?
            @user.update(skip_password_attribute?)
            flash[:alert] = "Profile successfully updated."
            redirect_to user_path(@user)
        elsif @user && @user.authenticate(params[:user][:password])
            @user.password = params[:user][:new_password]
            @user.save
            flash[:alert] = "Password changed"
            redirect_to user_path(@user)
        else
            render 'edit'
        end

	end

    private

    def user_params
        params.require(:user).permit(:name, :password, :email, :image, :password_confirmation, :new_password)
    end

    def skip_password_attribute?
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          user_params.except(:password, :password_confirmation)
        end
    end
end
