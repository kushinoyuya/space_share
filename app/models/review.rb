class Review < ApplicationRecord

    # アソシエーション
    belongs_to :restaurant
    belongs_to :user

end
