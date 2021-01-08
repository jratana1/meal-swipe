module ApplicationHelper
    def current_user(session)
        user ||= User.find_by(id: session[:user_id])
    end

    def is_logged_in?(session)
        !!Helpers.current_user(session)
    end
end
