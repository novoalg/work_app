class AddKarmaToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :karma, :integer, :default => 0
  end
end
