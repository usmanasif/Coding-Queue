class Askquestion < ActiveRecord::Base
  attr_accessible :title,:description,:tag,:view_counter,:votes,:answer_counter,:user_id,:tag_names

  validates :title, :presence => true
  #validates :description, :presence => true
  validates :tag_names, :presence => true

  validates :title, :length => { :minimum => 5 }
  #validates :tag_names, :length => { :minimum => 2  }

  #validates :description, :length => { :minimum => 5  }





  belongs_to :user
  has_many :askquestion_tags,:dependent =>:destroy
  has_many :tags, :through => :askquestion_tags
  has_many :answers

  attr_writer :tag_names


  attr_reader :tag_names



  define_index do
    indexes title, sortable: true
    indexes description
    indexes answers.answer, as: :answer
    indexes tags.name, as: :tag
    set_property :delta => true

  end











  #def to_indexed_json
  #  a = to_json(methods: [:answer])
  #  puts "#{'$' * 100}"
  #  puts a
  #  puts "#{'$' * 100}"
  #end
  #
  #def answer
  #  #answers.collect{ |ans| ans.answer }
  #  #tags.collect{|t| t.name}
  #  #user.email
  #
  #  #Askquestion.first.tags.map(&:name).join(", ")
  #  user.email
  #end





  def tag_names=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end









  after_save :assign_tags
def tag_names
  @tag_names || tags.map(&:name).join(' ')
end






  private
  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end












#validate :presence_of_tag_in_askquestion

#def presence_of_tag_in_askquestion
#  errors.add :tag, "must be a valid id" if self.tag_questions.blank?
#  errors.add :developed_bugs_id, "must be a valid developer id" if self.developer.blank?
end



