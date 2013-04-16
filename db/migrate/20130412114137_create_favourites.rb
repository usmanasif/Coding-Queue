class CreateFavourites < ActiveRecord::Migration
 	def self.up
  		create_table 'favourites' do |t|
    		t.column :user_id, :integer
    		t.column :askquestion_id, :integer
    		t.timestamps
  		end
	end
	def self.down
  		drop_table 'user_favourites'
	end
end
