class Reservation < ApplicationRecord

    # アソシエーション
    belongs_to :user
    belongs_to :restaurant, dependent: :destroy

    enum payment: [:代金引換,:銀行振込, :クレジットカード]
    enum usage_status: [:予約可,:予約済み,:予約不可]



end
