class Restaurant < ApplicationRecord

    # アソシエーション
    has_many :likes
    has_many :reviews
    has_many :reservations, dependent: :destroy
    # optional: trueはFKキーをNILL値で返せる（class:nillエラー対策）
    belongs_to :owner, optional: true

    # 画像ID（image_id）はActive_storageを使用
    has_many_attached :images
    default_scope -> { order ("id DESC")}

    # レストラン登録機能バリデーション
    validates :restaurant_name, presence: true
    validates :scheduled_usage_fee, presence: true
    validates :facility, presence: true
    validates :possible_day, presence: true
    validates :available_start_time, presence: true
    validates :available_end_time, presence: true
    validates :rest_day, presence: true
    validates :restaurant_address, presence: true
    validates :seat_number, presence: true
    validates :prefecture, presence: true

    # アクティブストレージバリデーション
    validate :images_presence
    def images_presence
        if images.attached?
        else
            errors.add(:image, 'ファイルを添付してください')
        end
    end


    # 都道府県の選択
    enum prefecture: { 北海道:0,青森県:1,岩手県:2,宮城県:3,秋田県:4,山形県:5,福島県:6,
    茨城県:7,栃木県:8,群馬県:9,埼玉県:10,千葉県:11,東京都:12,神奈川県:13,
    新潟県:14,富山県:15,石川県:16,福井県:17,山梨県:18,長野県:19,
    岐阜県:20,静岡県:21,愛知県:22,三重県:23,
    滋賀県:24,京都府:25,大阪府:26,兵庫県:27,奈良県:28,和歌山県:29,
    鳥取県:30,島根県:31,岡山県:32,広島県:33,山口県:34,
    徳島県:35,香川県:36,愛媛県:37,高知県:38,
    福岡県:39,佐賀県:40,長崎県:41,熊本県:42,大分県:43,宮崎県:44,鹿児島県:45,沖縄県:46 }

    # 定休日の選択
    # enum rest_day: { 月:0,火:1,水:2,木:3,金:4,土:5,日:6 }


    # いいね機能
    # def favorited_by(user)
    #     likes.where(user_id: user.id).exists?
    # end

end
