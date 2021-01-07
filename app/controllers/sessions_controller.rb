class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create, :home]
    
    def home
    end

    def new
        @users = User.all
    end

    def create
        user = User.find_by_id(params[:user_name])
        
        if user && user.authenticate(params[:user_password])
           session[:user_id] = user.id
           redirect_to user_path(user)
        else
           redirect_to signin_path
        end
    end

    def destroy
        reset_session
        redirect_to root_path
    end
end