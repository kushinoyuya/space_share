class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|

      t.integer :user_id, null: false
      t.integer :restaurant_id, null: false
      t.integer :payment, null: false
      t.string :restaurant_status, null: false
      t.string :usage_fee, null: false, :default => "2000"
      t.string :usage_status, null: false, :default => "1"
      t.timestamp :use_start_time, null: false
      t.timestamp :use_end_time, null: false
      t.string :usage_number, null: false
      t.timestamp :usage_day, null: false

      t.timestamps
    end
  end
end
