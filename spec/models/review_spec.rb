require 'rails_helper'

RSpec.describe Review, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "アソシエーション" do
    it "Userモデルに属している" do
      is_expected.to belong_to(:user)
    end
    it "Restaurantモデルに属している" do
      is_expected.to belong_to(:restaurant)
    end
  end

end
