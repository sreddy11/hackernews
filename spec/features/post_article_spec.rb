require 'spec_helper'

describe "Posting an article" do

  let!(:user) { FactoryGirl.create(:user) }
  before do
    login(user)    
    visit '/articles/new'
  end

  context "valid submission" do 
    before do
      fill_in "Title", :with => "title"
      fill_in "Url", :with => "http://www.news/com"
      click_button "Create Article"
    end

    it "should submit the article" do
      current_path.should == '/articles/1'
      page.should have_content('Post successfully created')
    end
  
  end

  context "invalid submission" do
    
    context "blank title" do
      before do
        fill_in "Title", :with => ""
        fill_in "Url", :with => "http://www.news.com"
        click_button "Create Article"
      end 
  
      it "should render a new article" do
        current_path.should == '/articles'
      end
    end

    context "invalid url" do
      before do
        fill_in "Title", :with => "title"
        fill_in "Url", :with => "news"
        click_button "Create Article"
      end 
  
      it "should render a new article" do
        current_path.should == '/articles'
      end
    end
  end
end
