class Restaurant < ApplicationRecord

    # アソシエーション
    has_many :likes
    has_many :reviews
    has_many :reservations
    belongs_to :owner, optional: true

    # 画像ID（image_id）はActive_storageを使用
    has_many_attached :images
    def thumbnail input
        return self.images[input].variant(resize: "300x300!").processed
    end

    # いいね機能
    # def favorited_by(user)
    #     likes.where(user_id: user.id).exists?
    # end

end
