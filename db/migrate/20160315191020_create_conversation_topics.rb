class CreateConversationTopics < ActiveRecord::Migration
  def change
    create_table :conversation_topics do |t|
      t.integer :conversation_id
      t.integer :topic_id

      t.timestamps null: false
    end
  end
end
