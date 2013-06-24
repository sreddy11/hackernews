class UpvotesController < VotesController

  before_filter :assign_parent
  before_filter :require_authentication

  def create
    @vote = current_vote || @parent.votes.new(:user => current_user)
    @vote.up_or_down = 1
    super
  end

  def destroy
    super
  end
end
