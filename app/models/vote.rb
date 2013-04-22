class Vote < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :votable, :polymorphic => true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:votable_id, :votable_type, :user_id]
end
