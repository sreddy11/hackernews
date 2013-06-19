class CommentsController < ApplicationController

  before_filter :find_parent
  before_filter :require_authentication, :only => [:new, :create]

  def index
    @comments = Comment.recent.limit(30)
  end

  def show
    if @parent != nil 
      @comment = @parent.comments.find(params[:id])
    else
      @comment = Comment.find(params[:id])
    end
  end

  def new
    @comment = @parent.comments.new
  end

  def create
    @comment = @parent.comments.new(params[:comment])
    @comment.commentable_type = @parent.class.name
    @comment.commentable_id = @parent.id
    @comment.user = current_user
    if @comment.save
      redirect_to(@parent)
    else
      render(:new)
    end
  end
  
  private

  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @parent =  $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
