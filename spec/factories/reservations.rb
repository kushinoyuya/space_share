FactoryBot.define do
  factory :reservation do
    # sequence(:restaurant_name) { |n| "restaurant_name#{n}" }
    usage_fee { "6000" }
    usage_day { "2019-10-19 00:00:00"  }
    use_start_time { "2019-10-19 13:03:30" }
    use_end_time { "2019-10-19 18:03:30" }
    usage_number { 5 }
    payment { 1 }

    association :user
    association :restaurant



    trait :no_usage_day do
      usage_day {}
    end

    trait :no_use_start_time do
      use_start_time {}
    end

    trait :no_use_end_time do
      use_end_time {}
    end

    trait :no_usage_number do
      usage_number {}
    end

    trait :no_payment do
      payment {}
    end



  end
end
