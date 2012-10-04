class AddCoulmnsInTag < ActiveRecord::Migration
  def self.up
    add_column :tags ,:askquestion_tag, :string
    add_column :tags ,:counter, :integer
    


  end
  def self.down

    remove_column :tags ,:askquestion_tag
    remove_column :tags ,:counter
    



  end
end
