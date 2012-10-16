class AddColumnVoteToAnswers < ActiveRecord::Migration

  def self.up
    add_column :answers ,:votes, :integer
  end

  def self.down
    remove_column :answers, :votes
  end

end
