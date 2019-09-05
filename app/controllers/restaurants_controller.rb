class RestaurantsController < ApplicationController

    def new

    end

    def create

    end

    def update

    end

    def index
        # 飲食店一覧画面、検索欄
        # include内は複数形
        @search = Restaurant.includes(:reservations).ransack(params[:q])
        @results = @search.result(distinct: true).order(rastaurant_order: "DESC").page(params[:page]).per(9)
    end

    def show
        @resturant = Restaurant.find(params[:id])
    end

    def edit

    end

end
