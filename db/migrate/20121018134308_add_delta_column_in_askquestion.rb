class AddDeltaColumnInAskquestion < ActiveRecord::Migration
  def self.up

    add_column :askquestions, :delta, :boolean, :default => true,
               :null => false
  end

  def self.down

    remove_column :askquestions, :delta

  end
end
