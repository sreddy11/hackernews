class Vote < ActiveRecord::Base

  attr_accessible :votable_id, :votable_type, :up_or_down

  belongs_to :user

  belongs_to :votable, :polymorphic => true

  validate :one_or_neg_one

  def one_or_neg_one
    if (self.up_or_down != 1 && self.up_or_down != -1)
      false
    else
      true
    end
  end

end
