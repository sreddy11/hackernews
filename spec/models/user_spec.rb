require 'spec_helper'

describe User do
  
  it { should validate_presence_of(:user_name) }
  it { should validate_uniqueness_of(:user_name) }
  it { should validate_presence_of(:password) }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should have_many(:articles) }

  it { should have_many(:comments) }


  let!(:user) { FactoryGirl.create(:user) }
  let!(:article) {FactoryGirl.create(:article, {:rating => 4, :user => user})}
  let!(:comment) {FactoryGirl.create(:comment, {:rating => -2, :user => user})}
   it "gets the karma points" do
    user.karma_points.should == article.rating + comment.rating
  end

end
