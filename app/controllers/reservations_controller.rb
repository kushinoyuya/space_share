class ReservationsController < ApplicationController

    before_action :authenticate_user!

    def new
        @reservation = Reservation.new
        @reservation.user_id = current_user.id
        # ルーティングを調整
        @restaurant = Restaurant.find(params[:restaurant_id])
        # render :new
        set_form_values
    end

    def create
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id
        @reservation.save
        redirect_to root_path, :notice => "予約完了しました"
    end

    def update

    end

    def index
        @reservations = Reservation.all

    end

    def destroy
        reservation = Reservation.find(params[:id])
        reservation.destroy
        redirect_to reservations_path, :alert => "予約をキャンセルしました。"
    end

    def show

    end

    def edit

    end


    private
    def set_form_values
        # 開始時間単位（00~24）hourの配列
        @reservation_use_start_time_hour = (0..23).to_a
        # 開始分単位（00~55）minの配列
        @reservation_use_start_time_min = (0..55).to_a
        # 終了時間単位（00~24）hourの配列
        @reservation_use_end_time_hour = (0..24).to_a
        # 終了分単位（00~55）minの配列
        @reservation_use_end_time_min = (0..55).to_a
    end


end
