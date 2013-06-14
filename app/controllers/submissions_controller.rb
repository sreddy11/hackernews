class SubmissionsController < ApplicationController

  def index
    @submissions = User.find_by_user_name(params[:user_id]).articles.order("updated_at DESC")
  end

end
