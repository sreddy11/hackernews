module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, :as => :votable
  end

  def num_upvotes
    votes.where(:up_or_down => 1).count
  end

  def num_downvotes
    votes.where(:up_or_down => -1).count
  end
 
end

