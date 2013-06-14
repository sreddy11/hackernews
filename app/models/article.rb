class Article < ActiveRecord::Base
  attr_accessible :url, :title

  validates :title, :url, :presence => true
  validates :url, :format => /^https?:\/\//

  scope :recent, order("updated_at DESC")
    
end
