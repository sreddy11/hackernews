class ArticlesController < ApplicationController
 
  before_filter :find_article, :only => [:show, :edit, :update, :destroy] 
  before_filter :require_authentication, :only => [:new, :create] 

  def index
    @articles = Article.recent.paginate(:page=>params[:page], :per_page => 20)
  end
 
  def show
   @article = Article.find(params[:id]) 
  end

  def new
    if logged_in?
      @article = Article.new
    else
      redirect_to(new_login_path, :error => "Please login first")
    end
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
