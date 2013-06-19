class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type

  validates :body, :presence => true

  scope :recent, order("created_at DESC")

  belongs_to :user
  belongs_to :article

  belongs_to :commentable, :polymorphic => true

  has_many :comments, :as => :commentable

  def has_parent?
    commentable_type == "Comment"
  end

  def parent
    Comment.find(commentable_id)
  end

  def has_children?
    Comment.where(:commentable_id => id, :commentable_type => "Comment").size > 0
  end

  def num_children?
    Comment.where(:commentable_id => id, :commentable_type => "Comment").size 
  end

  def children
    Comment.where(:commentable_id => id, :commentable_type => "Comment")
  end

  def article
    curr = self
    while(true)
      if curr.commentable_type == "Article"
        return Article.find(curr.commentable_id)
      else
        curr = Comment.find(curr.commentable_id)
      end
    end
  end

end
