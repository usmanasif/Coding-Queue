class CreateAskquestionTags < ActiveRecord::Migration
  def change
    create_table :askquestion_tags do |t|

      t.timestamps
    end
  end
end
