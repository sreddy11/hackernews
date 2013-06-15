class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :password_confirmation
 
  def to_param
    user_name
  end

  has_many :articles
  has_many :comments
  
  validates :user_name, :password, :password_confirmation, :presence => true
  validates :user_name, :uniqueness => true
  validates :password, :password_confirmation, :length => {:minimum => 6}
 
  has_secure_password
  
end
