class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :properties
  validates :email, :presence => true, :uniqueness => true

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :subscribers, :through => :inverse_friendships, :source => :user

  def login
		email[0...email.index('@')]
  end

  def has_friend?(user)
  	friends.include?(user)
  end

  def can_add_friend?(user)
  	!has_friend?(user)
  end

  def mutual_friendships
  	#friendships & inverse_friendships
  	friendships.joins('INNER JOIN friendships ff ON friendships.user_id = ff.friend_id and ff.user_id = friendships.friend_id').where(:user_id => id)
  end

  def notmutual_friendships
  	friendships - mutual_friendships
  end

  def my_subscribers
  	subscribers - friends 
  end

end
