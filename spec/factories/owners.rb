FactoryBot.define do
  factory :owner do
      sequence(:email) { |n| "example#{n}@test.com" }
      sequence(:last_name) {|n| "last_name#{n}" }
      sequence(:first_name) {|n| "first_name#{n}" }
      sequence(:last_kana) {|n| "last_kana#{n}" }
      sequence(:first_kana) {|n| "first_kana#{n}" }
      phone_number { Faker::Base.regexify(/0[0-9]{9,10}/) }
      password { Faker::Internet.password }
      password_confirmation { password }

      trait :no_last_name do
        last_name {}
      end
      trait :too_short_last_name do
        last_name {Faker::Lorem.characters(1)}
      end
      trait :too_long_last_name do
        last_name {Faker::Lorem.characters(21)}
      end

      trait :no_first_name do
        first_name {}
      end
      trait :too_long_first_name do
        first_name {Faker::Lorem.characters(21)}
      end
      trait :too_short_first_name do
        first_name {Faker::Lorem.characters(1)}
      end

      trait :no_last_kana do
        last_kana {}
      end
      trait :too_long_last_kana do
        last_kana {Faker::Lorem.characters(21)}
      end
      trait :too_short_last_kana do
        last_kana {Faker::Lorem.characters(1)}
      end

      trait :no_first_kana do
        first_kana {}
      end
      trait :too_long_first_kana do
        first_kana {Faker::Lorem.characters(21)}
      end
      trait :too_short_first_kana do
        first_kana {Faker::Lorem.characters(1)}
      end

      trait :no_phone_number do
        phone_number {}
      end
      trait :too_short_phone_number do
        phone_number {Faker::Lorem.characters(10)}
      end
      trait :too_long_phone_number do
        phone_number {Faker::Lorem.characters(11)}
      end
      # 0から始まるバリデーション

      trait :no_email do
        email {}
      end
      # メールアドレス【***@***.***】の形で入力バリデーション

      trait :create_with_restaurants do
        after(:create) do |owner|
          create_list(:restaurant, 3, owner: owner)
        end
      end

  end
end
