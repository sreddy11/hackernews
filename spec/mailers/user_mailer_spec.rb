require "spec_helper"

describe UserMailer do
  describe "reset_password" do
    let(:user) { FactoryGirl.create(:user, {:email => "abcd@yahoo.com", :reset_password_token => "token"}) }
    let(:mail) { UserMailer.reset_password(user) }

    it "checks the subject" do
      mail.subject.should eq("HackerNews: Reset Password")
    end
    it "check the recipient" do
      mail.to.should eq([user.email])
    end
    it "checks the sender" do
      mail.from.should eq(["reset_password@hackernews.com"])
    end
    it "checks the body" do
      mail.body.should include(edit_password_url(:token => user.reset_password_token))
    end
  end
end
