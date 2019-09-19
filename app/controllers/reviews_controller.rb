class ReviewsController < ApplicationController

    def new
        @review = Review.new
    end

    def create
        @restaurant = Restaurant.find(params[:restaurant_id])
        @review = @restaurant.reviews.build(review_params)
        @review.user_id = current_user.id
        @review.save
        redirect_to restaurant_path(@review.restaurant)
    end

    def destroy
        @review = Review.find(params[:id])
        restaurant = @review.restaurant
        @review.destroy
        redirect_to restaurant_path(restaurant)
    end

    def update
        @review = Review.find(params[:id])
        if @review.update(review_params)
            redirect_to restaurant_path(@review.restaurant)
        else
            render :restaurants_path
        end
    end

    def index

    end

    def show

    end

    def edit
        @review = Review.find(params[:id])
    end

    # ストロングパラメータ
    private
    def review_params
        params.require(:review).permit(:review_name, :comment)
    end



end
