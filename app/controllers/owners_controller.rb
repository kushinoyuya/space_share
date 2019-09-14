class OwnersController < ApplicationController

    before_action :authenticate_owner!
    before_action :correct_owner, except: [:change_password ]


    def new

    end

    def create

    end

    def update
        @owner = Owner.find(params[:id])
        # アカウント編集後、user/indexに遷移。ダメだったら、編集画面にレンダー。
        if @owner.update(owner_params)
            redirect_to owner_path
        else
            render :edit
        end
    end

    def index

    end

    def show
        @owner = Owner.find(params[:id])
        @restaurants = @owner.restaurants
    end

    def edit
        @owner = Owner.find(params[:id])
    end

    def change_password
        @user = current_user
    end




    # ストロングパラメータ
    private
    def owner_params
        params.require(:owner).permit(:last_name, :first_name, :last_kana, :first_kana, :phone_number, :email)
    end

    def correct_user
        # puts params(いらないかも)
        owner = Owner.find(params[:id])
        if current_owner != owner
            redirect_to root_path
        end
    end

    protected
    def update_resource(resource, params)
        resource.update_without_current_password(params)
    end


end
