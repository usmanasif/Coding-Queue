class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name,:counter
  
  has_many :askquestion_tags,:dependent =>:destroy
  has_many :askquestions, :through => :askquestion_tags

  validates_uniqueness_of :name










  def self.tokens(query)
    tags = where("name like ?", "%#{query}%" )
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags.map{ |tag| {  id: "#{tag.id}", name: "#{tag.name} X #{Tag.find_by_id(tag.id).askquestions.count}" } }


      #tags.map{|lan| [lan, Tag.find_by_name(lan).askquestion_tags.count]}
    end
  end


  def self.ids_from_tokens(tokens)

      tokens.gsub!(/<<<(.+?)>>>/){ create!(name: $1).id}
        tokens.split(',')

  end


end
