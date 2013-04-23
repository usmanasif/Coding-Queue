class AddDefaultValueOfRatingToUser < ActiveRecord::Migration
    def up
      remove_column :users, :rating
      add_column :users, :rating, :integer, :default => 0
    end

    def down
      remove_column :users, :rating
      add_column :users, :rating, :integer
    end
end