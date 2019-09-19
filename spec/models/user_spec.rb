require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  require ‘rails_helper’

RSpec.describe User, type: :model do
  /# pending “add some examples to (or delete) #{__FILE__}"/


  /# 以下テストコード作成/
  describe “アソシエーション” do
    it “Reservationモデルを多数持っている” do
      is_expected.to has_many(:reservations)
    end
    It “Reviewモデルを多数持っている” do
      is_expected.to has_many(:reviews)
    end
  end

  describe “実際に保存してみる” do
    context “保存できる場合” do
      It “バリデーションに引っかからない” do
        expect(FactoryBot.create(:user)).to be_valid
      end
    end

    context “保存できない場合” do
      It “名字 => 空欄” do
        expect(FactoryBot.bulid(:user, :no_last_name)).to_not_valid
      end
      it “last_nameが１文以下” do
        expect(FactoryBot.build(:user, :too_short_last_name)).to_not be_valid
      end
      it “last_nameが21文字以上” do
        expect(FactoryBot.build(:user, :too_long_last_name)).to_not be_valid
      end

      It “名前 => 空欄” do
        expect(FactoryBot.bulid(:user, :no_first_name)).to_not_valid
      end
      it “last_nameが１文以下” do
        expect(FactoryBot.build(:user, :too_short_first_name)).to_not be_valid
      end
      it “last_nameが21文字以上” do
        expect(FactoryBot.build(:user, :too_long_first_name)).to_not be_valid
      end

      It “カナ名字 => 空欄” do
        expect(FactoryBot.bulid(:user, :no_last_kana)).to_not_valid
      end
      it “last_kanaが１文以下” do
        expect(FactoryBot.build(:user, :too_short_last_kana)).to_not be_valid
      end
      it “last_kanaが21文字以上” do
        expect(FactoryBot.build(:user, :too_long_last_kana)).to_not be_valid
      end

      It “カナ名前 => 空欄” do
        expect(FactoryBot.bulid(:user, :no_first_kana)).to_not_valid
      end
      it “first_kanaが１文以下” do
        expect(FactoryBot.build(:user, :too_short_first_kana)).to_not be_valid
      end
      it “first_kanaが21文字以上” do
        expect(FactoryBot.build(:user, :too_long_first_kana)).to_not be_valid
      end

      It “電話番号 => 空欄” do
        expect(FactoryBot.bulid(:user, :no_phone_number)).to_not_valid
      end
      it “phone_numberが10桁以下” do
        expect(FactoryBot.bulid(:user, :too_short_phone_number)).to_not_valid
      end
      it “phone_numberが11桁以上” do
        expect(FactoryBot.bulid(:user, :too_long_phone_number)).to_not_valid
      end

    end

end
