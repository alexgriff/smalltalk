class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :conversation_id
      t.integer :rating

      t.timestamps null: false
    end
  end
end
