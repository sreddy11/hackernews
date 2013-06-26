class UsersController < ApplicationController

  def show
    @user = User.find_by_user_name!(params[:id])
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
end
