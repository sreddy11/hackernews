class Article < ActiveRecord::Base
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

  def num_comments
    comments = Comment.all
    sum = 0
    comments.each do |c|
      if c.article == self
        sum += 1
      end
    end
    return sum
  end 
    
end
