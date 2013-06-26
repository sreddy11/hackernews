class CommentsController < ApplicationController

  before_filter :assign_parent
  before_filter :require_authentication, :only => [:new, :create]

  def index
    if @parent.nil?
      @comments = Comment.recent.limit(30)
    else
      @comments = @parent.comments.recent.limit(30)
    end
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
    @comment.commentable = @parent   
    @comment.user = current_user
    if @comment.save
      redirect_to(@comment.article)
    else
      render(:new)
    end
  end

end
