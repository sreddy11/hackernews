class ArticlesController < ApplicationController

 
  before_filter :find_article, :only => [:show, :edit, :update, :destroy] 


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
      if session[:user_id]
        redirect_to(articles_path)
      else
        flash.now[:error] = "Please login first"
        render(:new)
      end
    else
      render(:new)
    end
  end

  

  private

  def find_article
    @article = Article.find(params[:id])
  end

end
