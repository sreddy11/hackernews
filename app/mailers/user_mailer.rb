class UserMailer < ActionMailer::Base
  default from: "reset_password@hackernews.com"
  
  def reset_password(user)
    @user = user
    mail :to => @user.email, :subject => "HackerNews: Reset Password"
  end
end
