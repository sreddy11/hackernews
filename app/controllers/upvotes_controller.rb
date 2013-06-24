class UpvotesController < ApplicationController

  before_filter :assign_parent
  before_filter :require_authentication

  def create
    @vote = current_vote || @parent.votes.new(:user => current_user)
    @vote.up_or_down = 1
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
