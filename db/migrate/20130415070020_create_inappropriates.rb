class CreateInappropriates < ActiveRecord::Migration
  def self.up
    create_table :inappropriates do |t|
      t.integer :user_id
      t.integer :askquestion_id

      t.timestamps
    end
  end
  def self.down
    drop_table :inappropriates

  end
end

