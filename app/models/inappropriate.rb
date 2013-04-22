class Inappropriate < ActiveRecord::Base
  attr_accessible :askquestion_id, :user_id
  belongs_to :user
  belongs_to :askquestion

  attr_accessible :entity_id, :entity

   validates_uniqueness_of :user_id, :scope => [:entity_id, :entity]
end
