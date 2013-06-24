class DownvotesController < ApplicationController
 
before_filter :find_parent
before_filter :require_authentication

  def create
    @vote = current_vote

    if @vote.nil?
      @vote = @parent.votes.new(:user => current_user)
    end

    @vote.up_or_down = -1
    @vote.save

    redirect_to(@parent)
  end

  def destroy
    @vote = current_vote
    unless @vote.nil?
      @vote.destroy
    end
    redirect_to(@parent)

  end


  private 
  
  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @parent =  $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def current_vote
    @current_vote ||= current_user.votes.for_votable(@parent).first
  end
end
