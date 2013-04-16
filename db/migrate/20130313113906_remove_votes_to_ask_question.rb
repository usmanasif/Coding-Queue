class RemoveVotesToAskQuestion < ActiveRecord::Migration
  def up
    remove_column :askquestions, :votes
  end

  def down
  end
end
