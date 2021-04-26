class ApplicationController < ActionController::Base
    before_action :find_user

    def find_user
        @error = params[:error]
        @user = session[:user]
    end
end
