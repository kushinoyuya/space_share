class UsersController < ApplicationController

    before_action :authenticate_user!
    before_action :correct_user, only: [:change_password, :edit, :update ]


    def update
        @user = User.find(params[:id])
        # アカウント編集後、user/indexに遷移。ダメだったら、編集画面にレンダー。
        if @user.update(user_params)
            redirect_to users_path
        else
            render :edit
        end
    end

    def change_password
        @user = current_user
    end

    def index
    end

    def show
        # @like = Like.find(params[:id])
        @user = User.find(params[:id])
        @likes = @user.likes
        @reservations = @user.reservations
    end

    def edit
        @user = User.find(params[:id])
    end


    # ストロングパラメータ
    private
    def user_params
        params.require(:user).permit(:last_name, :first_name, :last_kana, :first_kana, :phone_number, :email)
    end

    def correct_user
        # puts params(いらないかも)
        user = User.find(params[:id])
        if current_user != user
            redirect_to root_path
        end
    end

    protected
    def update_resource(resource, params)
        resource.update_without_current_password(params)
    end


end
