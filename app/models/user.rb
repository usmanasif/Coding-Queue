class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :username, :email, :password, :password_confirmation, :authentications_attributes

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates_confirmation_of :password
  validates :password, :presence => true, :on => :create
  validates :email, :presence => true
  validates :username, :presence => true
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_format_of :email, :with => /[a-zA-Z0-9_-]+\@[a-zA-Z0-9_-]+\.\w+/

  has_many :askquestions,:dependent => :destroy
  has_many :answers
  has_many :votes
  has_many :comments

end

