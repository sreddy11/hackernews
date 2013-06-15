class Article < ActiveRecord::Base
  attr_accessible :url, :title

  belongs_to :user

  validates :title,:url, :presence => true
  validates :url, :format => /^https?:\/\//

  scope :recent, order("updated_at DESC")

  has_many :comments
  
  def domain
     URI.parse(url).host
  end


    
end
