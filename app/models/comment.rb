class Comment < ActiveRecord::Base
  include Commentable
  include Votable

  attr_accessible :body, :commentable_id, :commentable_type, :rating

  validates :body, :presence => true

  scope :recent, order("created_at DESC")

  scope :by_user, lambda { |user| where(:user_id => user.id) }

  belongs_to :user

  belongs_to :commentable, :polymorphic => true

  def has_parent_comment?
    commentable.is_a?(Comment)
  end

  alias_method :parent, :commentable
  alias_method :children, :comments
 
  def article
    if commentable.is_a?(Article)
      parent
    else
      commentable.article
    end
  end
end
