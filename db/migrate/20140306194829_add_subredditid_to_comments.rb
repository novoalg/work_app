class AddSubredditidToComments < ActiveRecord::Migration
  def change
    add_column :comments, :subreddit_id, :integer
  end
end
