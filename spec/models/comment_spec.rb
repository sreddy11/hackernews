require 'spec_helper'

describe Comment do

  it { should validate_presence_of(:body) }
  it { should belong_to(:user) }

  it_behaves_like "a commentable" do
    let!(:commentable) {FactoryGirl.create(:comment)}
  end
  
  it { should have_many(:votes) }
end
