# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# ユーザーテーブル
User.create!(
    email: "useruser@user.com",
    encrypted_password: "abc123",
    reset_password_token: "aaa123",
    reset_password_sent_at: "aaa123",
    remember_created_at: "123abc",
    sign_in_count: "kkkkk",
    current_sign_in_at: "kkkkk",
    last_sign_in_at: "kkkkk",
    current_sign_in_ip:"kkkkk",
    last_sign_in_ip: "kkkkk",
    last_name: "kushi",
    first_name: "yuya",
    last_kana: "kushi",
    first_kana: "yuya",
    phone_number: "0120777777",
    created_at: "2019/08/30",
    updated_at: "2019/08/30",
    password: "abc123"
)

# オーナーテーブル
Owner.create!(
    email: "owner@owner.com",
    encrypted_password: "abc123",
    reset_password_token: "aaa123",
    reset_password_sent_at: "aaa123",
    remember_created_at: "123abc",
    sign_in_count: "kkkkk",
    current_sign_in_at: "kkkkk",
    last_sign_in_at: "kkkkk",
    current_sign_in_ip:"kkkkk",
    last_sign_in_ip: "kkkkk",
    last_name: "kushi",
    first_name: "yuya",
    last_kana: "kushi",
    first_kana: "yuya",
    phone_number: "0120777777",
    created_at: "2019/08/31",
    updated_at: "2019/08/31",
    password: "abc123"
)

# レストランテーブル
Restaurant.create!(
    owner_id: "1",
    restaurant_name: "Bar-Ishida",
    restaurant_address: "神南101",
    facility: "Wifi 電源あり",
    scheduled_usage_fee: "10000",
    available_start_time: "2019-09-02 18:00:15",
    available_end_time: "2019-09-02 19:00:15",
    seat_number: "4",
    usage_status: "予約可能",
    prefecture: "北海道",
    created_at: "2019/08/30",
    updated_at: "2019/08/30",
    rest_day: "月"
)


# いいねテーブル
Like.create!(
    user_id: "1",
    restaurant_id: "1",
    created_at: "2019/09/01",
    updated_at: "2019/09/01"
)

# レビューテーブル
Review.create!(
    user_id: "1",
    restaurant_id: "1",
    review_name: "串カツさん",
    comment: "綺麗だった",
    created_at: "2019/09/02",
    updated_at: "2019/09/02"
)

# 予約テーブル
Reservation.create!(
    user_id: "1",
    restaurant_id: "1",
    restaurant_status: "予約中",
    usage_fee: "10000",
    use_start_time: "2019-09-02 15:00:15",
    use_end_time: "2019-09-02 17:00:15",
    usage_number: "4",
    usage_day: "2019/09/30",
    payment: "クレジットカード",
    created_at: "2019/08/30",
    updated_at: "2019/08/30"
)
