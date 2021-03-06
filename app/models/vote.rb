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

  after_save :recalculate_rating
  after_destroy :recalculate_rating

  scope :upvotes, where(:up_or_down => 1)
  scope :downvotes, where(:up_or_down => -1)

  private

  def recalculate_rating
    votable.update_attribute(:rating, votable.num_upvotes - votable.num_downvotes)
  end
end
