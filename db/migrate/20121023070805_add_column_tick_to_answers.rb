class AddColumnTickToAnswers < ActiveRecord::Migration

  def self.up
    add_column :answers ,:tick_status, :integer
    remove_column :answers, :votes
  end


  def self.down
    remove_column :answers, :tick_status
    add_column :answers, :votes, :integer
  end

end
