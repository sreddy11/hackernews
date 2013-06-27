require 'spec_helper'

describe User do
  
  it { should validate_presence_of(:user_name) }
  it { should validate_uniqueness_of(:user_name) }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should have_many(:articles) }

  it { should_not allow_value("not_an_email").for(:email) }
  it { should allow_value("123@yahoo.com").for(:email) }

  it { should have_many(:comments) }


  describe "test karma_points method" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:article) {FactoryGirl.create(:article, {:rating => 4, :user => user})}
    let!(:comment) {FactoryGirl.create(:comment, {:rating => -2, :user => user})}
    
    it "gets the karma points" do
      user.karma_points.should == article.rating + comment.rating
    end
  end

  describe "test send_reset_password method" do
    let(:user) { FactoryGirl.create(:user) }

    it "generates a new reset_password_token each time" do
      user.send_password_reset
      previous = user.reset_password_token
      user.send_password_reset
      user.reset_password_token.should_not == previous
    end

    it "send the user an email" do
      sent_email = user.send_password_reset
      sent_email.to.should == [user.email]
    end
  end

end
