class DeleteColumnFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :review_id
  end
end
