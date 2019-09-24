class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|

      t.integer :owner_id, null: false
      t.integer :prefecture, null: false
      t.string :restaurant_name, null: false
      t.string :restaurant_address, null: false
      t.string :facility, null: false
      t.string :scheduled_usage_fee, null: false
      t.timestamp :available_start_time, null: false
      t.timestamp :available_end_time, null: false
      t.string :seat_number, null: false
      # 画像ID（image_id）はActive_storageを使用


      t.timestamp :rest_day,  null: false

      t.timestamps
    end
  end
end
