class VotesController < ApplicationController
  
  before_filter :assign_parent
  before_filter :require_authentication

  def create
    if @parent.voted?(current_user)
      current_vote.update_attributes(:up_or_down => params[:up_or_down]) 
    else
      @vote = @parent.votes.new(:user_id => current_user.id, :up_or_down => params[:up_or_down])
      @vote.save
    end
      redirect_to(@parent)
  end
  
  def destroy
    current_vote.try(:destroy)
    redirect_to(@parent)
  end
  
  def current_vote
    @current_vote ||= current_user.votes.for_votable(@parent).first
  end
end
