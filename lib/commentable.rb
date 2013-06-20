module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, :as => :commentable
  end

  def num_comments
    count = comments.count

    comments.each do |c|
      count += c.num_comments
    end

    count
  end

   
  def has_children?
    comments.any?
  end

  def num_children?
    comments.size 
  end

end

