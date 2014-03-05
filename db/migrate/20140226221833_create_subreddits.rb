class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :subname
      t.integer :user_id

      t.timestamps
    end
    
    add_index :subreddits, [:user_id, :created_at]
  end
end
