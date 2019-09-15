class RestaurantsController < ApplicationController

    # APIを叩くための準備
    require 'uri'
    require 'net/http'
    require 'json'

    def new
        @restaurant = Restaurant.new
        # set_form_values
    end

    def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.owner_id = current_owner.id

        if @restaurant.save
            redirect_to owner_path(current_owner), :notice => "登録しました"
        else
            flash.now[:alert] = "登録に失敗しました"
            @restaurant = Restaurant.new
            # set_form_values
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

        # 日本語のエンコードを定義する
        query = URI.encode_www_form(address: @restaurant.restaurant_address)
        uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{query}&key=#{ENV['GOOGLE_MAP_KEY']}")
        json = Net::HTTP.get(uri) #NET::HTTPを利用してAPOを叩く

        @results = JSON.parse(json)
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

    def map
        results = Geocoder.search(params[:restaurant_address])
        @latlng = results.first.coordinates
        # これでmap.js.erbで、経度緯度情報が入った@latlngを使える。
        respond_to do |format|
            format.js
        end
    end


    private
    def restaurant_params
        params.require(:restaurant).permit(:owner_id, :restaurant_name, :restaurant_address, :facility, :scheduled_usage_fee, :available_start_time, :available_end_time, :prefecture, :rest_day, images: [])
    end

end
