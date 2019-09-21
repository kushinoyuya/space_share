require 'rails_helper'

RSpec.describe Reservation, "モデルに関するテスト", type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

    describe "アソシエーション" do
      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end
      it "Restaurantモデルに属している" do
        is_expected.to belong_to(:restaurant)
      end
    end

    describe "実際に保存してみる"do
      context "保存できる場合" do
        # ここ
        it "user_idを入れて保存" do
          user = FactoryBot.create(:user)
          restaurant = FactoryBot.create(:restaurant)
          expect(FactoryBot.create(:reservation, user_id: user.id, restaurant: restaurant)).to be_valid
        end
      end

      context "保存できない場合" do
        it "usage_day => 空欄" do
          expect(FactoryBot.build(:reservation, :no_usage_day)).to_not be_valid
        end
        # ここ
        it "use_start_time => 空欄" do
          expect(FactoryBot.build(:reservation, :no_use_start_time)).to_not be_valid
        end

        # it "if use_end_time < use_start_time"
        #   expect().to_not be_valid
        # end

        it "use_end_time => 空欄" do
          expect(FactoryBot.build(:reservation, :no_use_end_time)).to_not be_valid
        end
        it "usage_number => 空欄" do
          expect(FactoryBot.build(:reservation, :no_usage_number)).to_not be_valid
        end
        it "payment => 空欄" do
          expect(FactoryBot.build(:reservation, :no_payment)).to_not be_valid
        end
        # timeoutバリデーション


        # dayoutバリデーション


        # 今日ではなく昨日以前であった場合に、エラー



      end
    end


end
