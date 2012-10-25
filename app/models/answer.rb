class Answer < ActiveRecord::Base
  attr_accessible :askquestion_id, :user_id, :answer, :active


  validates :answer, :presence => true

  belongs_to :askquestion
  belongs_to :user

  after_save :set_askquestion_delta_flag
  after_destroy :set_askquestion_delta_flag

  private

  def set_askquestion_delta_flag
    askquestion.delta = true
    askquestion.save
  end

end
