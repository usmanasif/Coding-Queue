class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|

      t.integer :askquestion_id

      t.integer :user_id

      t.string :answer

      t.boolean :active


      t.timestamps
    end
  end
end
