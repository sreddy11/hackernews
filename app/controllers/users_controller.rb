class UsersController < ApplicationController

  def show
    @user = User.find_by_user_name!(params[:id])
    @karma = karma_points
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
      redirect_to articles_path, :notice => "Your Account (#{@user.user_name}) has been successfully created"
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  private

  def karma_points
    ratings = @user.articles.map{|a| a.rating} + @user.comments.map{|a| a.rating}
    ratings.each.inject(0) {|sum,i| sum + i}
  end
    

end
