class AddColumnStatusToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes ,:status, :integer
  end

  def self.down
    remove_column :votes, :status
  end

end
