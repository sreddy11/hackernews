class Comment < ActiveRecord::Base
  include Commentable

  attr_accessible :body, :commentable_id, :commentable_type

  validates :body, :presence => true

  scope :recent, order("created_at DESC")

  belongs_to :user

  belongs_to :commentable, :polymorphic => true


  def has_parent_comment?
    commentable.is_a?(Comment)
  end


  alias_method :parent, :commentable
  alias_method :children, :comments
 
  def article
    if parent.is_a?(Article)
      parent
    else
      parent.article
    end
  end
end
