class RestaurantsController < ApplicationController

    # APIを叩くための準備
    require 'uri'
    require 'net/http'
    require 'json'


    def new
        @restaurant = Restaurant.new
    end

    def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.owner_id = current_owner.id
        if @restaurant.save
            redirect_to owner_path(current_owner)
            flash[:notice] = "登録しました"
        else
            flash.now[:alert] = "登録に失敗しました。 入力内容を確認してください。"
            @restaurant = Restaurant.new
            render :new
        end
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
            # デバック
            binding.pry
            redirect_to restaurants_path, flash[:notice] = "更新できました"
        else
            flash.now[:alert] = "入力内容を確認してください"
            render :new
        end
    end

    def index
        # 飲食店一覧画面、検索フォーム
        # include内は複数形
        @search = Restaurant.includes(:reservations).ransack(params[:q])
        @results = @search.result(distinct: true)
        # .order(rastaurant_order: "DESC")
    end

    def show
        @restaurant = Restaurant.find(params[:id])
        # 飲食店テーブルに紐づいたレビューを複数表示させる
        @reviews = @restaurant.reviews.page(params[:page]).per(3)
        # 日本語のエンコードを定義する
        query = URI.encode_www_form(address: @restaurant.restaurant_address)
        # GCPからAPIを取得する
        uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{query}&key=#{ENV['GOOGLE_MAP_KEY']}")
        #NET::HTTPを利用してAPOを叩く
        json = Net::HTTP.get(uri)
        # 文字列を JSON として解析し、文字列によって記述されている JavaScript の値やオブジェクトを構築
        @results = JSON.parse(json)
        # JSONコードを@resultsと定義して、@geometryに再定義する
        @geometry = @results["results"][0]["geometry"]["viewport"]["northeast"]
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
    def restaurant_params
        params.require(:restaurant).permit(:owner_id, :restaurant_name, :restaurant_address, :facility, :possible_day, :scheduled_usage_fee, :rest_day, :available_start_time, :available_end_time, :prefecture, :seat_number, images: [])
    end

end
