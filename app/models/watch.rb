class Watch < ActiveRecord::Base
  attr_accessible :askquestion_id, :user_id
  belongs_to :user
  belongs_to :askquestion

  validates_uniqueness_of :user_id, :scope => [:askquestion_id]
end
