class ReservationsController < ApplicationController

    before_action :authenticate_user!

    def new
        @reservation = Reservation.new
        @reservation.user_id = current_user.id
        @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def create
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

    def reservation_params
        params.require(:reservation).permit(:user_id, :restaurant_id, :payment, :usage_fee, :use_start_time, :use_end_time, :usage_number, :usage_day)
    end


end
