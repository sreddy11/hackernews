require 'spec_helper'

describe "Creating an account" do

  before do
    visit '/login'
    click_link "Need an account? Register here"
  end

  it "should go to the new user page" do
    current_path.should == '/users/new'
  end

  context "valid form" do
    before do 
      fill_in "Username", :with => 'sreddy1'
      fill_in "Password", :with => "password"
      fill_in "Confirm Password", :with => "password"
      fill_in "E-mail", :with => "email@yahoo.com"
      click_button "Create User"
    end

    it "should create the account" do
      current_path.should == '/articles'
      page.should have_content("Your Account (sreddy1) has been successfully created")
    end
  end

  context "invalid form" do
    let!(:user) { FactoryGirl.create(:user) }
    before do 
      fill_in "Username", :with => user.user_name
      fill_in "Password", :with => "pass"
      fill_in "Confirm Password", :with => "pass2"
      fill_in "E-mail", :with => "email"
      click_button "Create User"
    end

    it "should give new errors" do
      current_path.should == '/users'
      page.should have_content("User name has already been taken")
      page.should have_content("Password is too short (minimum is 6 characters")
      page.should have_content("Password doesn't match confirmation")
      page.should have_content("Not a valid e-mail format")
    end
  end
end
