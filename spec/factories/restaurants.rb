FactoryBot.define do
  factory :restaurant do
    sequence(:restaurant_name) { |n| "restaurant_name#{n}" }
    sequence(:facility) { |n| "facility#{n}" }
    sequence(:restaurant_address) { |n| "restaurant_address#{n}" }

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
