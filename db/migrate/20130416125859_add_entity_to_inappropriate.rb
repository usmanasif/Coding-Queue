class AddEntityToInappropriate < ActiveRecord::Migration
  def self.up
    add_column :inappropriates, :entity_id, :integer
    add_column :inappropriates, :entity, :string

  end
  def self.down
    remove_column :inappropriates ,:entity_id
    remove_column :inappropriates ,:entity
  end

end
