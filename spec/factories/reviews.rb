FactoryBot.define do
  factory :review do
    sequence(:review_name) { |n| "review_name#{n}" }
    sequence(:comment) { |n| "comment#{n}" }
    restaurant_id { 2 }
    association :user
    #association :restaurant
  end
end
