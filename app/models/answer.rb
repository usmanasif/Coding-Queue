class Answer < ActiveRecord::Base
  attr_accessible :askquestion_id, :user_id, :answer, :active


  validates :answer, :presence => true

  belongs_to :askquestion
  belongs_to :user
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable

  after_save :set_askquestion_delta_flag
  after_destroy :set_askquestion_delta_flag

  private

  def set_askquestion_delta_flag
    askquestion.delta = true
    askquestion.save
  end


  def vote_calculate(question)
    arr = []
    cal_votes = Answer.find_all_by_askquestion_id(question)
    cal_votes.each do |vote|
      arr << [vote.votes.sum(:status), vote.id]
    end
    arr.sort
    arr2 = arr.sort{|x,y| y<=> x}

    vote_answer = []
    arr2.each do |x,y|
      vote_answer << Answer.find(y)
    end
    return vote_answer
  end

end
