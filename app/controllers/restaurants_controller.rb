class RestaurantsController < ApplicationController

    def new
        @restaurant = Restaurant.new
        set_form_values
    end

    def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.available_start_time = params[:restaurant][:available_start_time_hour] + ":" + params[:restaurant][:available_start_time_min]
        @restaurant.available_end_time = params[:restaurant][:available_end_time_hour] + ":" + params[:restaurant][:available_end_time_min]

        if params[:restaurant][:available_start_time_hour].to_i > params[:restaurant][:available_end_time_hour].to_i
            flash.now[:alert] = "登録に失敗しました"
            # 処理を中断させる
            @restaurant = Restaurant.new
            set_form_values
            render :new
            return
        end

        if @restaurant.save
            redirect_to restaurants_path(@restaurant), :notice => "登録しました"
        else
            flash.now[:alert] = "登録に失敗しました"
            @restaurant = Restaurant.new
            set_form_values
            render :new
        end
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
            redirect_to restaurants_path, :notice => "更新できました"
        else
            flash.now[:alert] = "入力内容を確認してください"
            render :new
        end
    end

    def index
        # 飲食店一覧画面、検索欄
        # include内は複数形
        @search = Restaurant.includes(:reservations).ransack(params[:q])
        @results = @search.result(distinct: true).order(rastaurant_order: "DESC").page(params[:page]).per(9)
    end

    def show
        @restaurant = Restaurant.find(params[:id])
        # 飲食店テーブルに紐づいたレビューを複数表示させる
        @reviews = @restaurant.reviews.page(params[:page]).per(3)
        if user_signed_in?
            if current_user.reviews.any?
                @review = current_user.reviews.find_by(restaurant_id: @restaurant.id)
                @review = Review.new if @review.nil?
            else
                @review = Review.new
            end
        end


    end

    def edit
        @restaurant = Restaurant.find(params[:id])
    end

    private

    def set_form_values
        # 開始時間単位（00~24）hourの配列
        @restaurant_available_start_time_hour = (0..23).to_a
        # 開始分単位（00~55）minの配列
        @restaurant_available_start_time_min = (0..55).to_a
        # 終了時間単位（00~24）hourの配列
        @restaurant_available_end_time_hour = (0..24).to_a
        # 終了分単位（00~55）minの配列
        @restaurant_available_end_time_min = (0..55).to_a
    end

    def restaurant_params
        params.require(:restaurant).permit(:owner_id, :restaurant_name, :restaurant_address, :facility, :scheduled_usage_fee, :available_start_time, :available_end_time, prefecture:[], images: [])
    end

end
