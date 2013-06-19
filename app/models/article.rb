class Article < ActiveRecord::Base
  include Commentable
  
  attr_accessible :url, :title

  belongs_to :user

  validates :title,:url, :presence => true
  validates :url, :format => /^https?:\/\//

  scope :recent, order("updated_at DESC")

  has_many :comments, :as => :commentable
  
  def domain
    begin
      URI.parse(url).host
    rescue Exception 
      ''
    end
  end
end
