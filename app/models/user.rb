class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :password_confirmation
 
  has_many :articles
  
  validates :user_name, :password, :password_confirmation, :presence => true
  validates :user_name, :uniqueness => true
  validates :password, :password_confirmation, :length => {:minimum => 6}
 
  has_secure_password
  
end
