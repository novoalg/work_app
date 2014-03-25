class AddCommentsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :comment_id, :integer
    add_index :votes, :comment_id
    
  end
end
