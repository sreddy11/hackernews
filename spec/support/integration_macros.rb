require "spec_helper" 

module IntegrationMacros

  def login(user = FactoryGirl.create(:user))
    visit root_path
    click_link "Login/Register"
    fill_in "login_user_name", :with => user.user_name
    fill_in "Password", :with => user.password
    click_button 'Login'
  end
end
