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
end

