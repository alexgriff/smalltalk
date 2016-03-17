class ChangeColumnInConversations < ActiveRecord::Migration
  def change
    change_column :conversations, :time, :datetime
  end
end
