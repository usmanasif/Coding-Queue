class Favourite < ActiveRecord::Base
  attr_accessible :askquestion_id, :user_id
  belongs_to :user
  belongs_to :askquestion

end
