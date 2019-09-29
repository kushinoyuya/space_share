class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# バリデーション
  # 苗字 => 空欄だめ、1文字〜20文字以内で入力
  validates :last_name, presence: true, length: { in: 1..20 }
  # 名前 => 空欄だめ、1文字〜20文字以内で入力
  validates :first_name, presence: true, length: { in: 1..20 }
  # 苗字(カナ) => 空欄だめ、1文字〜20文字以内で入力
  validates :last_kana, presence: true, length: { in: 1..20 }, format: { with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/ }
  # 名前(カナ) => 空欄だめ、1文字〜20文字以内で入力
  validates :first_kana, presence: true, length: { in: 1..20 }, format: { with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/ }
  # 電話番号 => 空欄だめ、0から始まる10桁〜11桁で入力
  VALID_PHONE_REGEX = /\A0[0-9]{9,10}\z/
  validates :phone_number, presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }
  # メールアドレス => 空欄だめ、【***@***.***】の形で入力　例:aaa@aa.a
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }


# アソシエーション
has_many :reservations, dependent: :destroy
has_many :likes, dependent: :destroy
has_many :reviews, dependent: :destroy

end
