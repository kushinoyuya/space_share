class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|

      t.integer :user_id
      t.integer :restaurant_id
      t.string :review_name
      t.string :comment


      t.timestamps
    end
  end
end
