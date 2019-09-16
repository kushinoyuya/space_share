class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|

      t.integer :owner_id, null: false, default: ""
      t.integer :prefecture, null: false, default: ""
      t.string :restaurant_name, null: false, default: ""
      t.string :restaurant_address, null: false, default: ""
      t.string :facility, null: false, default: ""
      t.string :scheduled_usage_fee, null: false, default: ""
      t.timestamp :available_start_time, null: false, default: ""
      t.timestamp :available_end_time, null: false, default: ""
      t.string :seat_number, null: false, default: ""
      # 画像ID（image_id）はActive_storageを使用


      t.timestamp :rest_day,  null: false, default: ""

      t.timestamps
    end
  end
end
