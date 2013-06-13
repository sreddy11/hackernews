class ArticlesController < ApplicationController

 
  before_filter :find_article, :only => [:show, :edit, :update, :destroy] 
  before_filter :require_authentication, :only => [:new, :create] 

  def index
    @articles = Article.newest
  end
 
  def show
    
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
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
