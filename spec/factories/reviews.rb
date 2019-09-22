FactoryBot.define do
  factory :review do
    association :user
    association :restaurant
  end
end
