class ArticlesController < ApplicationController

 
  before_filter :find_article, :only => [:show, :edit, :update, :destroy] 
  before_filter :require_authentication, :only => [:new, :create] 

  def index
    @articles = Article.recent.paginate(:page=>params[:page], :per_page => 20)
  end
 
  def show
    
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    @article.user = current_user
    if @article.save
      redirect_to(article_path(@article), :notice => "Post successfully created")
    else
      render(:new)
    end
  end

  

  private


  def find_article
    @article = Article.find(params[:id])
  end

  def require_authentication
    if !logged_in?
      flash[:error] = "Please login first"
      redirect_to(new_login_path)
    end 
  end

  
end
