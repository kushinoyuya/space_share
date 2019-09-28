class ReservationsController < ApplicationController

    before_action :authenticate_user!

    def new
        @reservation = Reservation.new
        @reservation.user_id = current_user.id
        # ルーティングを調整
        @restaurant = Restaurant.find(params[:restaurant_id])
        # render :new
        # いらない
        # set_form_values
    end

    def create
        # binding.pry
        # reservation_paramsが空の値があればリダイレクト
        # if @reservation.blank?
        #     redirect_to new_reservation_path(@reservation)
        #     flash.now[:alert] = "未入力の情報があります。もう一度確認してください。"
        # end
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id
        @restaurant = @reservation.restaurant
        if @reservation.save
            redirect_to restaurant_path(@restaurant)
            flash[:notice] = "登録しました"
        else
            render :new
        end
    end

    def update
        @reservation = Reservation.find(params[:id])
        @reservation.update(reservation_params)
        redirect_to user_path(current_user.id)
    end

    def index
        # @reservations = Reservation.all
    end

    def destroy
        user = current_user
        reservation = Reservation.find(params[:id])
        reservation.destroy
        redirect_to user_path(current_user)
    end

    def show
    end

    def edit
        @reservation = Reservation.find(params[:id])
        @user = current_user
    end


    # クレジットカード
    def pay
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
        Payjp::Charge.create(
            :amount => params[:amount],
            :card => params['payjp-token'],
            :currency => 'jpy'
        )
    end



    private
    # def set_form_values
    #     # 開始時間単位（00~24）hourの配列
    #     @reservation_use_start_time_hour = (0..23).to_a
    #     # 開始分単位（00~55）minの配列
    #     @reservation_use_start_time_min = (0..55).to_a
    #     # 終了時間単位（00~24）hourの配列
    #     @reservation_use_end_time_hour = (0..24).to_a
    #     # 終了分単位（00~55）minの配列
    #     @reservation_use_end_time_min = (0..55).to_a
    # end

    def reservation_params
        params.require(:reservation).permit(:user_id, :restaurant_id, :payment, :usage_fee, :use_start_time, :use_end_time, :usage_number, :usage_day)
    end


end
