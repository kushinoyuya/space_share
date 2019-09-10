class ReservationsController < ApplicationController

    before_action :authenticate_owner!

    def new
        @reservation = Reservation.new
        # @reservation.user_id = current_user.id
        @restaurant = Restaurant.find(params[:id])

        # render :new
    end

    def create

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

end
