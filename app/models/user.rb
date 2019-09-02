class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # デバイス
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # アソシエーション
  has_many :reservations
  has_many :likes
  has_many :reviews

end
