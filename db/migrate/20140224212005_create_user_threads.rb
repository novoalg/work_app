class CreateUserThreads < ActiveRecord::Migration
  def change
    create_table :user_threads do |t|
      t.string :title
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :user_threads, [:user_id, :created_at]
  end
end
