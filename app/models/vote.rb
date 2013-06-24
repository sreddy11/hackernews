class Vote < ActiveRecord::Base

  attr_accessible :user, :user_id, :votable, :votable_id, :votable_type, :up_or_down

  belongs_to :user

  belongs_to :votable, :polymorphic => true

  validates :up_or_down, :inclusion => {:in => [-1,1]}

  validates :votable_id, :votable_type, :presence => true

  scope :for_votable, lambda { |votable|
    where(:votable_id => votable.id, :votable_type => votable.class.name)
  }

  scope :for_user, lambda { |user| where(:user_id => user.id) }

  scope :upvotes, where(:up_or_down => 1)
  scope :downvotes, where(:up_or_down => -1)
end
