class ChangeConvDatetimeToDate < ActiveRecord::Migration
  def change
    change_column :conversations, :time, :date
  end
end
