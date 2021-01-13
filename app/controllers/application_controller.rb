class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :require_login
    
    protected

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def signed_in?
      !!current_user
    end
    helper_method :current_user, :signed_in?
  
    def current_user=(user)
      session[:user_id] = user&.id
      @current_user = user
    end
    
    private
  
    def require_login
      redirect_to root_path unless session.include? :user_id
    end 
    
    def require_no_session
      redirect_to user_path(current_user) if session.include? :user_id
    end

    def belongs_current_user
      redirect_to user_path(current_user) if current_user.friendly_id != params[:id]
    end
end
