class CreateAskquestions < ActiveRecord::Migration
  def change
    create_table :askquestions do |t|

      t.timestamps
    end
  end
end
