class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :description, :name_event,:points
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :description,
            :presence => {:message => "can't be blank"}
end
