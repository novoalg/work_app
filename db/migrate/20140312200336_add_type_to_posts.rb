class AddTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_link, :boolean 
  end
end
