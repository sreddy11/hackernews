class CommentsController < ApplicationController

  before_filter :find_article
  before_filter :require_authentication, :only => [:new, :create]

  def index
    @comments = @article.comments.recent
  end

  def show
    @comment = @article.comments.find(params[:id])
  end

  def new
    @comment = @article.comments.new
  end

  def create
    @comment = @article.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to(@comment.article)
    else
      render(:new)
    end
  end
  
  private

  def find_article
    @article = Article.find(params[:article_id])
  end
end
