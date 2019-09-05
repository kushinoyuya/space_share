class ReviewsController < ApplicationController

    def new
        @review = Review.new(review_params)

    end

    def create

    end

    def update

    end

    def index

    end

    def show

    end

    def edit

    end

    # ストロングパラメータ
    private
    def review_params
        require(:review).permit(:review_name, :comment, :restaurant_id)
    end



end
