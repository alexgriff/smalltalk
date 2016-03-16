class AddCommentColumnToReviewsTable < ActiveRecord::Migration
  def change
    add_column :reviews, :comment, :text  
  end
end
