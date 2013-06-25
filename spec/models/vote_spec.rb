require 'spec_helper'

describe Vote do

  it { should belong_to(:user) }
  it { should belong_to(:votable) }
  
  it { should allow_value(1).for(:up_or_down) }
  it { should allow_value(-1).for(:up_or_down) }
  it { should_not allow_value(0).for(:up_or_down) }
  
  it { should validate_presence_of(:votable_id) }
  it { should validate_presence_of(:votable_type) }

  let!(:user) {FactoryGirl.create(:user)}
  let!(:article) {FactoryGirl.create(:article)}
  let!(:upvote) {FactoryGirl.create(:vote, {:votable=> article, :user => user, :up_or_down => 1})}
  
  it "test for_votable scope" do
    user.votes.for_votable(article).should == [upvote]
  end

  it "test for_user scope do" do
    article.votes.for_user(user).should == [upvote]
  end

end
