class AddToComment < ActiveRecord::Migration
    def change
        add_column :comments, :reply, :string
    end
end
