class AddKarmaToComments < ActiveRecord::Migration
  def change
    add_column :comments, :karma, :integer, :default => 0
  end
end
