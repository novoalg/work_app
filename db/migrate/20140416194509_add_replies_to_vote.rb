class AddRepliesToVote < ActiveRecord::Migration
  def change
    add_column :votes, :reply_id, :integer
    add_index :votes, :reply_id
  end
end
