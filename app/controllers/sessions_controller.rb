class SessionsController < ApplicationController

    def new
    end

    def create
    end

    def destroy
        CASClient::Frameworks::Rails::Filter.logout(self)
    end
end
