class AddSubredditidToComments < ActiveRecord::Migration
  def change
    add_column :comments, :subreddit_it, :integer
  end
end
