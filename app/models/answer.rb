class Answer < ActiveRecord::Base
  attr_accessible :askquestion_id, :user_id, :answer, :active


  validates :answer, :presence => true

  belongs_to :askquestion
  belongs_to :user


end
