class Vote < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :votable, :polymorphic => true
  belongs_to :user
end
