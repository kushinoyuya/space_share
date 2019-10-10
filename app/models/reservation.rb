class Reservation < ApplicationRecord
    require 'date'

    # アソシエーション
    belongs_to :user
    belongs_to :restaurant
    default_scope -> { order ("id DESC")}

    # 予約登録バリデーション（既存のバリデーションの場合は複数）
    validates :usage_day, presence: true
    validates :use_start_time, presence: true
    validates :use_end_time, presence: true
    validates :usage_number, presence: true
    validates :payment, presence: true


    # バリデーション定義(自作の場合は単数)
    validate :timeout
    validate :dayout
    validate :seat_number
    validate :invalidtime

    # 開始と終了の時間が逆転するのを防ぐ
    def timeout
        begin
            if use_end_time.present? && use_start_time.present? && use_end_time < use_start_time
                errors.add(:use_start_time, ": 正しい予約時間を入力してください")
            end
        rescue NoMethodError
            errors.add(:use_start_time, ": 無効な値です")
        end
    end

    # 過去の日付をバリデーション
    def dayout
        if usage_day.present? && usage_day < Date.today
            errors.add(:usage_day, ": 過去の日付は使えません")
        end
    end

    def total_usage_number
        restaurant.reservations.where(usage_day: usage_day).sum(:usage_number).to_i + usage_number.to_i
    end

    # seat_number < (予約席+今回の予約人数) =>error
    def seat_number
        if restaurant.seat_number.to_i < total_usage_number.to_i
            errors.add(:seat_number, ": 予約できません")
        end
    end

    def invalidtime
        if restaurant.available_start_time > use_start_time || restaurant.available_end_time < use_end_time
            errors.add(:use_start_time, ": 利用時間外です")
        end
    end

    # enum定義
    enum payment: [:現地払い, :銀行振込, :クレジットカード]
    enum usage_status: [:予約可, :予約済み, :予約不可]




end
