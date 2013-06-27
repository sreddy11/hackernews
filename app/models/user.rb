class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :password_confirmation, :email
 
  def to_param
    user_name
  end

  has_many :articles
  has_many :comments
  has_many :votes

  validates :user_name, :password, :password_confirmation, :presence => true, :on => :create
  validates :user_name, :uniqueness => true
  validates :password, :password_confirmation, :length => {:minimum => 6}, :on => :create
  validates :email, :presence => :true, :uniqueness => :true, 
    :email_format => { message: "Not a valid e-mail format" }
  has_secure_password

  def karma_points
    ratings = articles.map{|a| a.rating} + comments.map{|a| a.rating}
    ratings.sum
  end
 
  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(self).deliver
  end

  def generate_token(token_type)
    begin
      self[token_type] = SecureRandom.urlsafe_base64
    end while User.exists?(token_type => self[token_type])
  end
end
