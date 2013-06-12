class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to articles_path, :notice =>"Your Account (#{@user.user_name}) has been successfully created"
    else
      render(:new)
    end
  end

end
