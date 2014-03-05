class AddToSubreddit < ActiveRecord::Migration

  def change
    add_column :subreddits, :title, :string
    add_column :subreddits, :description, :string
  end
    
end
