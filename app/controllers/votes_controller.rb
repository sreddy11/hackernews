class VotesController < ApplicationController

  protected

  def create
    @vote.save
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
