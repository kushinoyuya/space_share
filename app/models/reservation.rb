class Reservation < ApplicationRecord

    # アソシエーション
    belongs_to :user
    belongs_to :restaurant, dependent: :destroy

    enum payment: { 現地払い:0,銀行振込:1,:クレジットカード:2 }
    enum usage_status: { 予約可:0,予約済み:1,予約不可:2 }




end
