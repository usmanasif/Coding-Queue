class AddRatingToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :rating, :integer
  end

  def self.down
    remove_column :users, :rating, :integer
  end
end