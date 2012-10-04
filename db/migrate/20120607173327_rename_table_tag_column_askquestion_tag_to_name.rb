class RenameTableTagColumnAskquestionTagToName < ActiveRecord::Migration
  def self.up
    rename_column :tags, :askquestion_tag, :name
  end

  def self.down
    rename_column :tags, :name, :askquestion_tag
  end

end
