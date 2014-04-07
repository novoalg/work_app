class CreateReplies < ActiveRecord::Migration

  def change
    create_table :replies do |t|
      t.references :user
      t.references :comment

      t.timestamps
    end
    add_index :replies, :user_id
    add_index :replies, :comment_id
  end

end
