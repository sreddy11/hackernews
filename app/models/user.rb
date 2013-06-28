class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :password_confirmation, :email
 
  def to_param
    user_name
  end

  has_many :articles
  has_many :comments
  has_many :votes

  validates :user_name, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 6},:if => lambda {|a| a.password.present?}
  validates :email, :presence => :true, :uniqueness => :true, 
    :email_format => { message: "Not a valid e-mail format" }
  has_secure_password

  def karma_points
    ratings = articles.map{|a| a.rating} + comments.map{|a| a.rating}
    ratings.sum
  end
 
  def send_password_reset
    set_new_token
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(self).deliver
  end

  def set_new_token
    begin
      self[:reset_password_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:reset_password_token => self[:reset_password_token])
    self[:reset_password_token]
  end
end
