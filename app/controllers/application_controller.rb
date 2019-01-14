class ApplicationController < ActionController::Base
    private
    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end
    helper_method :current_user

    def signed_in?
        current_user.present?
    end
    helper_method(:signed_in?)

    def authenticate_user!
        unless signed_in?
            flash[:danger] = "Please sign in or sign up"
            redirect_to new_session_url
        end
    end
end
