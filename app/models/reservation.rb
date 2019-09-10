class Reservation < ApplicationRecord

    # アソシエーション
    belongs_to :user
    belongs_to :restaurant, dependent: :destroy

end
