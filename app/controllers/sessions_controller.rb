class SessionsController < ApplicationController

    def new
    end

    def create
     user = User.find_by_username(params[:session][:username])
     if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_back_or user
        flash[:success] = "Welcome User!"
     else
        flash.now[:warning] = "Username and password do not match" 
        render 'new'
     end
    end

    def destroy
        sign_out
        redirect_to root_url
    end
end
