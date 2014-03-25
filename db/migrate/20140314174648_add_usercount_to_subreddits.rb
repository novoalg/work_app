class AddUsercountToSubreddits < ActiveRecord::Migration
  def change
    add_column :subreddits, :user_count, :integer, :default => 0
  end
end
