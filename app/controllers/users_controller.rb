class UsersController < ApplicationController

  def show
    @user = User.find_by_user_name(params[:id])
  end

  def new
    if logged_in?
      redirect_to(articles_path, :notice => "Please logout of the current account first")
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to(articles_path, :notice => "Account successfully created")
    else
      render :new
    end
  end

  def submissions
     @submissions = User.find_by_user_name(params[:id]).articles
  end

end
