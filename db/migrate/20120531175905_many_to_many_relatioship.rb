class ManyToManyRelatioship < ActiveRecord::Migration
  def self.up
    add_column :askquestion_tag_questions ,:askquestion_id, :integer
    add_column :askquestion_tag_questions ,:tag_question_id, :integer


  end
  def self.down
    remove_column :askquestion_tag_questions ,:askquestion_id
    remove_column :askquestion_tag_questions ,:tag_question_id
    

  end
end
