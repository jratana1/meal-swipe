class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create, :home]
    
    def home
    end

    def new
        @user = User.new
    end

    def create
        user = User.find_by_name(params[:user][:name]) 
        if user && user.authenticate(params[:user][:password])         
            session[:user_id] = user.id
           redirect_to user_path(user)
        else
           render 'new'
        end
    end

    def destroy
        reset_session
        redirect_to root_path
    end
end