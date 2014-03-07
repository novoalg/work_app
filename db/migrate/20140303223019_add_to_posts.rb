class AddToPosts < ActiveRecord::Migration
    def change
        add_column :posts, :url, :string
        add_column :posts, :subname, :string
    end
end
