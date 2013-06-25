module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, :as => :votable
  end

  def num_upvotes
    votes.upvotes.count
  end

  def num_downvotes
    votes.downvotes.count
  end

  def user_vote(user)
    votes.for_user(user).first
  end

  def voted?(user)
    votes.for_user(user).any?
  end
  
  def upvoted?(user)
    votes.for_user(user).upvotes.any?
  end

  def downvoted?(user)
    votes.for_user(user).downvotes.any?
  end
end

