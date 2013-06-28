require 'spec_helper'

describe "Reset lost password" do

  before do
    visit '/login'
    click_link "Forgot password"
  end

  it "should be at the reset page" do
    current_path.should == '/password/new'
  end

  describe "email input" do
  
    context "no email in database" do
      
      before do
        fill_in "Email", :with => "email"
        click_button "Reset Password"
      end
      
      it "should render a new form" do
        current_path.should == '/password'
        page.should have_content("No account matches the e-mail provided.")
      end
    end

    context "Email exists in database" do

      let!(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "Email", :with => user.email
        click_button "Reset Password"
      end
      
      it "should render a new form" do
        current_path.should == '/articles'
        page.should have_content("E-mail has been sent regarding resetting password.")
      end
    end
  end

  describe "resetting password" do
    context "Request not expired" do
      let!(:user) { FactoryGirl.create(:user, {:reset_password_token => "example", 
                                       :reset_password_sent_at => Time.now})}

      before do
        visit "/password/edit?token=#{user.reset_password_token}"
      end

      it "should have password fields" do
        page.should have_content("Password confirmation")
        page.should have_content("Password")
      end

      context "invalid password fields" do
        
        before do
          fill_in "Password", :with => "pass"
          fill_in "Password confirmation", :with => "pass2"
          click_button "Update Password"
        end

        it "should render a new form" do
          page.should have_content("Password did not update. Please try again.")
          page.should have_content("Password is too short (minimum is 6 characters)")
          page.should have_content("Password doesn't match confirmation")
        end
      end

      context "valid password fields" do
        
        before do
          fill_in "Password", :with => "password"
          fill_in "Password confirmation", :with => "password"
          click_button "Update Password"
        end

        it "should reset the password" do
          current_path.should == '/articles'
          page.should have_content("Password has been reset!")
        end
      end



    end

    context "Request expired" do
      let!(:user) { FactoryGirl.create(:user, {:reset_password_token => "example", 
                                       :reset_password_sent_at => 5.hours.ago})}

      before do
        visit "/password/edit?token=#{user.reset_password_token}"
      end

      it "should have password fields" do
        current_path.should == '/password/new'
        page.should have_content("Password reset request has expired")
      end
    end

  end
    


end
