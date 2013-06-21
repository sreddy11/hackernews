class VotesController < ApplicationController
 
  before_filter :find_parent
  before_filter :require_authentication

  def index
  end
  
  def new
    @vote = @parent.votes.new
  end

  def create
    @vote = @parent.votes.new(:up_or_down => params[:up_or_down])
    @vote.user = current_user
    @vote.save
    redirect_to(@parent)
  end

  def destroy
    @vote = @parent.votes.find(:user_id) 
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


end
