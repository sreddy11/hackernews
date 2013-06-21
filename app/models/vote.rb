class Vote < ActiveRecord::Base

  attr_accessible :user, :votable, :votable_id, :votable_type, :up_or_down

  belongs_to :user

  belongs_to :votable, :polymorphic => true

  validates_inclusion_of :up_or_down, :in => [-1,1]

  validate [:votable, :user], :uniqueness => true

  scope :for_votable, lambda { |votable|
    where(:votable_id => votable.id, :votable_type => votable.class.name)
  }
end
