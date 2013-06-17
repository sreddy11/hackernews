class SubmissionsController < ApplicationController

  def index
    @submissions = user.articles.order("updated_at DESC")
  end

  private

  def user
    @user ||= User.find_by_user_name(params[:user_id])
  end
  
  helper_method :user
end
