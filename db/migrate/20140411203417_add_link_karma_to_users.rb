class AddLinkKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_karma, :integer, :default => 0
  end
end
