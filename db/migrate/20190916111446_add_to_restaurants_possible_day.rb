class AddToRestaurantsPossibleDay < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :possible_day, :datetime
  end
end
