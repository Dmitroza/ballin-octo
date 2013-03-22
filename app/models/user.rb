class User < ActiveRecord::Base
  has_many :properties
  attr_accessible :email
  validates :email, :presence => true, :uniqueness => true, :email => true
end
