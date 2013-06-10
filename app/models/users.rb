class User < ActiveRecord::Base
 attr_accessible :user_name, :first_name, :last_name, :password, :confirm_password, :email
 attr_acessor :password
 validates :user_name, :first_name, :last_name, :password, :confirm_password, :email, :presence => true
 validates :user_name, :uniqueness => true, :length => { :in => 6..20 }
 validates :password, :length => { :minimum => 6 }
 validates :email, :uniqueness => :true
 validates email_realness_of :email
 validates_confirmation_of :password

end
