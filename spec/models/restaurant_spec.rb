require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "アソシエーション" do
    it "Reservationモデルを複数持っている" do
      is_expected.to have_many(:reservations)
    end
    it "Ownerモデルに属している" do
      is_expected.to belong_to(:owner)
    end
    it "Reviewモデルを複数持っている" do
      is_expected.to have_many(:reviews)
    end
  end

    describe "実際に保存してみる" do
      context "保存できる場合"
        it "owner_idを入れて保存" do
          owner = FactoryBot.create(:owner)
          expect(FactoryBot.create(:restaurant, owner_id: owner.id)).to be_valid
        end
      end


      context "保存できない場合"
        it "店舗名 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_restaurant_name)).to_not be_valid
        end
        it "利用予定料金 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_scheduled_usage_fee)).to_not be_valid
        end
        it "設備 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_facility)).to_not be_valid
        end
        it "利用可能日 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_possible_day)).to_not be_valid
        end
        it "利用開始時刻 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_available_start_time)).to_not be_valid
        end
        it "利用終了時刻 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_available_end_time)).to_not be_valid
        end
        it "定休日 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_rest_day)).to_not be_valid
        end
        it "店舗住所 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_restaurant_address)).to_not be_valid
        end
        it "座席数 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_seat_number)).to_not be_valid
        end
        it "都道府県 => 空欄" do
          expect(FactoryBot.build(:restaurant, :no_prefecture)).to_not be_valid
        end
        # アクティブストレージどうする？
      # context
      # end
    # describe
    # end


# Rspec
end
