class ArticlesController < ApplicationController
 
  before_filter :find_article, :only => [:show, :edit, :update, :destroy] 
  before_filter :require_authentication, :only => [:new, :create]

  def index
    @articles = Article.recent.paginate(:page=>params[:page], :per_page => 20)
  end
 
  def show
    @comment = @article.comments.new
    @article = Article.find(params[:id]) 
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(params[:article])
    if @article.save
      redirect_to @article, :notice => "Post successfully created"
    else
      render(:new)
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

end
