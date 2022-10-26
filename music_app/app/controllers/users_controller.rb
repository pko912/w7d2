class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :required_logged_out, only: [:new,:create]
    # before_action :required_logged_in, only: [:show]


    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login(@user)
            redirect_to user_url(id: @user.id)
        else
            render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:password_digest,:session_token)
    end

end