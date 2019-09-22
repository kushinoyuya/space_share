FactoryBot.define do
  factory :restaurant do
    # 初期値を設定
    sequence(:restaurant_name) { |n| "restaurant_name#{n}" }
    sequence(:facility) { |n| "facility#{n}" }
    sequence(:restaurant_address) { |n| "restaurant_address#{n}" }
    scheduled_usage_fee { 300 }
    possible_day { "2019-10-19" }
    available_start_time { "2019-10-19 13:03:30" }
    available_end_time { "2019-10-19 18:03:30" }
    rest_day { "2019-10-20" }
    seat_number { 5 }
    prefecture { 0 }

    # アソシエーション設定
    association :owner

    after(:build) do |restaurant|
      restaurant.images.attach(fixture_file_upload(Rails.root.join('spec', 'fixtures', 'image5.jpg'), 'image/jpg'))
    end


    trait :no_restaurant_name do
      restaurant_name {}
    end

    trait :no_scheduled_usage_fee do
      scheduled_usage_fee {}
    end

    trait :no_facility do
      facility {}
    end

    trait :no_possible_day do
      possible_day {}
    end

    trait :no_available_start_time do
      available_start_time {}
    end

    trait :no_available_end_time do
      available_end_time {}
    end

    trait :no_rest_day do
      rest_day {}
    end

    trait :no_restaurant_address do
      restaurant_address {}
    end

    trait :no_seat_number do
      seat_number {}
    end

    trait :no_prefecture do
      prefecture {}
    end


  end
end
