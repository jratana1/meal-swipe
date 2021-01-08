class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create, :home, :oauth]
    
    def home
    end

    def new
        @user = User.new
    end

    def create
        @user = User.find_by_name(params[:user][:name]) 
        if @user && @user.authenticate(params[:user][:password])         
            session[:user_id] = @user.id
           redirect_to user_path(@user)
        elsif @user == nil
            flash[:alert] = "Error: User not found."
            redirect_to signin_path(@user)
        else
            flash[:alert] = "Error: Username/Password incorrect"
            redirect_to signin_path(@user)
        end
    end

    def oauth  
        @user = User.find_or_create_by(facebook_id: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
            u.password = SecureRandom.hex(9)
            u.password_confirmation = u.password
        end
      
        session[:user_id] = @user.id
      
        redirect_to user_path(@user)
    end

    def destroy
        reset_session
        flash[:alert] = "You are now Signed Out!"
        redirect_to root_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end