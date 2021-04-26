class SessionsController < ApplicationController
    def login; end

    def register; end

    def auth
        auth_params

        result = Authenticate.call(params[:user])

        if result.success?
            session[:user] = result.user
            redirect_to home_path
        else
            redirect_to action: "login", error: result.message
        end
    end

    def create
        auth_params

        result = Register.call(params[:user])

        if result.success?
            session[:user] = result.user
            redirect_to home_path
        else
            redirect_to action: "login", error: result.message
        end
    end

    def logout
        session[:user] = nil
        redirect_to home_path
    end

    private

    def auth_params
        params.require(:user)
    end
end
