class Reservation < ApplicationRecord

    # アソシエーション
    belongs_to :user
    belongs_to :restaurant

    # バリデーション定義
    validate :timeout, :dayout,
    # validate :seat_number, :numericality => { :greater_than_or_equal_to => 0 }

    # 開始と終了の時間が逆転するのを防ぐ
    def timeout
        if use_end_time < use_start_time
            errors.add(:use_start_time, ": 正しい予約時間を入力してください")
        end
    end

    # 過去の日付をバリデーション
    def dayout
        if usage_day.present? && usage_day < Date.today
            errors.add(:usage_day, ": 過去の日付は使えません")
        end
    end

    def total_usage_number
        restaurant.reservations.where(usage_day: usage_day).inject(seat_number) { |sum, reservation| sum + reservation.seat_number }
    end

    # seat_number < (予約席+今回の予約人数) =>error
    def seat_number
        if restaurant.seat_number.to_i < total_usage_number.to_i
            errors.add(:seat_number, ": 予約できません")
        end
    end

    # enum定義
    enum payment: [:現地払い, :銀行振込, :クレジットカード]
    enum usage_status: [:予約可, :予約済み, :予約不可]



end
