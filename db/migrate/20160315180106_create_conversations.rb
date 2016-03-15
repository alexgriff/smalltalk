class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :partner_id
      t.date :time
  

      t.timestamps null: false
    end
  end
end
