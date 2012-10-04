class CreateAskquestionTagQuestions < ActiveRecord::Migration
  def change
    create_table :askquestion_tag_questions do |t|
      t.timestamps
    end
  end
end
