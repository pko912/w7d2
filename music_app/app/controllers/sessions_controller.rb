class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :required_logged_out, only: [:new, :create]
    before_action :required_logged_in, only: [:destroy]

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username],params[:user][:password])
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Invalid Credentials']
            render :new
        end
    end

    def destroy
        logged_out!
        flash[:messages] = ["Successfully logged out"]
        redirect_to new_session_url
    end

end