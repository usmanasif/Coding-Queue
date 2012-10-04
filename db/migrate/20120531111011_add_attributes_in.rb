class AddAttributesIn < ActiveRecord::Migration
  def self.up
    add_column :askquestions ,:title, :string
    add_column :askquestions ,:description, :string
    add_column :askquestions ,:tag, :string
    add_column :askquestions ,:view_counter, :integer
    add_column :askquestions ,:votes, :integer
    add_column :askquestions ,:answer_counter, :integer
    add_column :askquestions ,:user_id, :integer

  end
  def self.down
    remove_column :askquestions ,:title
    remove_column :askquestions ,:description
    remove_column :askquestions ,:tag
    remove_column :askquestions ,:view_counter
    remove_column :askquestions ,:votes
    remove_column :askquestions ,:answer_counter
    remove_column :askquestions ,:user_id
    
    

  end
end
