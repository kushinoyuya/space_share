class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|

      t.integer :user_id, null: false
      t.integer :restaurant_id, null: false

      t.timestamps
    end
  end
end
