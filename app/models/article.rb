class Article < ActiveRecord::Base
  include Commentable
  include Votable
  
  attr_accessible :url, :title

  belongs_to :user

  validates :title,:url, :presence => true
  validates :url, :format => /^https?:\/\//

  scope :recent, order("updated_at DESC")

  scope :in_date_range, lambda { |start, stop| where("created_at >= :start AND created_at <= :end",
                                                          {:start => start, :end => stop})}
                             
  scope :by_rating, order("rating DESC")

  def domain
    begin
      URI.parse(url).host
    rescue Exception 
      ''
    end
  end
end
