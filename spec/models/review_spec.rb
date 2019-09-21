require 'rails_helper'

RSpec.describe Review, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "アソシエーション" do
    it "Userモデルに属している" do
      is_expected.to belong_to(:users)
    end
    it "Restaurantモデルに属している" do
      is_expected.to belong_to(:restaurants)
    end
  end

end
