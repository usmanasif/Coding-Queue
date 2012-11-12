class RemoveColumnCountVotes < ActiveRecord::Migration
  def self.up
    remove_column :votes ,:count, :integer
  end

  def self.down
    add_column :votes, :count, :integer
  end

end
