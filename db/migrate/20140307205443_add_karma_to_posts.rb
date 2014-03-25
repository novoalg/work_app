class AddKarmaToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :karma, :integer, :default => 0
  end
end
