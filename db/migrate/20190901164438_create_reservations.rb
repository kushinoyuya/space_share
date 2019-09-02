class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|

      t.integer :user_id, null: false, default: ""
      t.integer :restaurant_id, null: false, default: ""
      t.string :restaurant_status, null: false, default: ""
      t.string :usage_fee, null: false, default: ""
      t.string :usage_time, null: false, default: ""
      t.string :usage_number, null: false, default: ""

      t.timestamps
    end
  end
end
