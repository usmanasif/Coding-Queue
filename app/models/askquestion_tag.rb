class AskquestionTag < ActiveRecord::Base
  # attr_accessible :title, :body
belongs_to :askquestion
belongs_to :tag

end
