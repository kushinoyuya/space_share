class LikesController < ApplicationController
    before_action :set_variables, only: [:create, :destroy]

    def index
        @likes = current_user.likes.page(params[:page]).per(5)
        @restaurant = restaurant.new
    end

    def create
            like = current_user.likes.new(restaurant_id: @restaurant.id)
            like.save
            flash.now[:notice] = "「#{@restaurant.restaurant_name}」にいいねしました。"
    end

    def destroy
        like = current_user.likes.where(restaurant_id: @restaurant.id)
        like.destroy_all
        flash.now[:alert] = "「#{@restaurant.album}」のいいねを取り消しました。"
    end

    # ストロングパラメータ
    private
    def set_variables
        @restaurant = restaurant.find(params[:restaurant_id])
        @id_name = "#like-link-#{@restaurant.id}"
        @id_heart = "#heart-#{@restaurant.id}"
    end
    def restaurant_params
        params.require(:user).permit(:name, :price, :image)
    end
    def like_params
        params.require(:like).permit(:restaurant_id)
    end

end
