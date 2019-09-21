require 'rails_helper'

RSpec.describe Owner, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "アソシエーション" do
    it "Restaurantモデルを多数持っている" do
      is_expected.to have_many(:restaurants)
    end
  end

  describe "実際に保存してみる" do
    context "保存できる場合" do
      it "バリデーションに引っかからない" do
        expect(FactoryBot.build(:owner)).to be_valid
      end
    end

    context "保存できない場合" do
      it "名字 => 空欄" do
        expect(FactoryBot.build(:owner, :no_last_name)).to_not be_valid
      end
      it "last_nameが１文以下" do
        expect(FactoryBot.build(:owner, :too_short_last_name)).to_not be_valid
      end
      it "last_nameが21文字以上" do
        expect(FactoryBot.build(:owner, :too_long_last_name)).to_not be_valid
      end

      it "名前 => 空欄" do
        expect(FactoryBot.build(:owner, :no_first_name)).to_not be_valid
      end
      it "last_nameが１文以下" do
        expect(FactoryBot.build(:owner, :too_short_first_name)).to_not be_valid
      end
      it "last_nameが21文字以上" do
        expect(FactoryBot.build(:owner, :too_long_first_name)).to_not be_valid
      end

      it "カナ名字 => 空欄" do
        expect(FactoryBot.build(:owner, :no_last_kana)).to_not be_valid
      end
      it "last_kanaが１文以下" do
        expect(FactoryBot.build(:owner, :too_short_last_kana)).to_not be_valid
      end
      it "last_kanaが21文字以上" do
        expect(FactoryBot.build(:owner, :too_long_last_kana)).to_not be_valid
      end

      it "カナ名前 => 空欄" do
        expect(FactoryBot.build(:owner, :no_first_kana)).to_not be_valid
      end
      it "first_kanaが１文以下" do
        expect(FactoryBot.build(:owner, :too_short_first_kana)).to_not be_valid
      end
      it "first_kanaが21文字以上" do
        expect(FactoryBot.build(:owner, :too_long_first_kana)).to_not be_valid
      end

      it "電話番号 => 空欄" do
        expect(FactoryBot.build(:owner, :no_phone_number)).to_not be_valid
      end
      it "phone_numberが10桁以下" do
        expect(FactoryBot.build(:owner, :too_short_phone_number)).to_not be_valid
      end
      it "phone_numberが11桁以上" do
        expect(FactoryBot.build(:owner, :too_long_phone_number)).to_not be_valid
      end
      # 0から始まるバリデーション

      # メールアドレス空欄
      it "メールアドレス=> 空欄" do
        expect(FactoryBot.build(:owner, :no_email)).to_not be_valid
      end
    end
  end
end
