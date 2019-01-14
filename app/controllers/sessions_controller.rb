class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by_email params[:email]

        if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Welcome #{user.first_name}!"
        else
            flash[:danger] = "Email or Password is incorrect"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path
        flash[:primary] = "You have logged out"
    end
end
