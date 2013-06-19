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
    sum = 0
    done = true
    curr = self.comments
    while (done)
      curr.each  do |c|
        sum +=1
        if c.has_children? 
          Rails.logger.debug("set done to false")
          done = false
        end
      end
      temp = []
      curr.each do |c|
        temp += c.children.to_a
        Rails.logger.debug("#{temp}")
      end
      curr = temp
    end
    return sum
  
        
  end

    
end
