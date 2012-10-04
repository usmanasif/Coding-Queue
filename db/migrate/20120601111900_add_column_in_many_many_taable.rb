class AddColumnInManyManyTaable < ActiveRecord::Migration
   def self.up
    add_column :askquestion_tags ,:askquestion_id, :integer
    add_column :askquestion_tags ,:tag_id, :integer
    


  end
  def self.down

    remove_column :askquestion_tags ,:askquestion_id
    remove_column :askquestion_tags ,:tag_id




  end
end
