class Comment < ActiveRecord::Base
  attr_accessible :body

  validates :body, :presence => true

  scope :recent, order("created_at DESC")

  belongs_to :user
  belongs_to :article


end
