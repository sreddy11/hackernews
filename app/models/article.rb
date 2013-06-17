class Article < ActiveRecord::Base
  attr_accessible :url, :title

  belongs_to :user

  validates :title,:url, :presence => true
  validates :url, :format => /^https?:\/\//

  scope :newest, order("updated_at DESC")

  
  def domain
    begin
      URI.parse(url).host
    rescue Exception 
      ''
    end
  end


    
end
