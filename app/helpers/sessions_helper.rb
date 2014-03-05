module SessionsHelper

    def edit
        @user = User.find(params[:id])
    end

    def current_user
        @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end

    def current_user?(user)
        user == current_user
    end

end
