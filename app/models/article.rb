class Article < ActiveRecord::Base
  include Commentable
  include Votable
  
  attr_accessible :url, :title

  belongs_to :user

  validates :title,:url, :presence => true
  validates :url, :format => /^https?:\/\//

  scope :recent, order("updated_at DESC")

  scope :by_year, lambda { |date| all(:conditions => ["created_at >= :start AND created_at <= :end", 
                          {:start => date.beginning_of_year, :end => date.end_of_year }]).
                          sort {|b,a| a.num_upvotes <=> b.num_upvotes} }

  scope :by_month, lambda { |date| all(:conditions => ["created_at >= :start AND created_at <= :end", 
                             {:start => date.beginning_of_month, :end => date.end_of_month }]).
                             sort {|b,a| a.num_upvotes <=> b.num_upvotes} }

  scope :by_day, lambda { |date| all(:conditions => ["created_at >= :start AND created_at <= :end", 
                             {:start => date.beginning_of_day, :end => date.end_of_day }]).
                             sort {|b,a| a.num_upvotes <=> b.num_upvotes} }




  
  def domain
    begin
      URI.parse(url).host
    rescue Exception 
      ''
    end
  end
end
