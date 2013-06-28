require 'spec_helper'

describe "Make Comments" do

  let!(:user) { FactoryGirl.create(:user) }
  before do
    login(user)    
  end
  
  context "Comment on Article" do
    let!(:article) {FactoryGirl.create(:article) }
    before do
      visit '/articles/1/comments/new'
    end
    
    context "blank comment" do
      before do
        fill_in "Body", :with =>""
        click_button "Add Comment"
      end

      it "renders a new form" do
        current_path.should == "/articles/1/comments"
      end
    end

    context "valid comment" do
      before do
        fill_in "Body", :with => "New comment"
        click_button "Add Comment"
      end

      it "accepts the comment" do
        current_path.should == "/articles/1"
        page.should have_content("New comment")
      end
    end
  end

  context "Comment on Comment" do
    let!(:article) {FactoryGirl.create(:article) }
    before do 
      visit '/articles/1/comments/new'
      fill_in "Body", :with => "New comment"
      click_button "Add Comment"
      visit '/comments/1'
    end

    context "blank body" do
      before do
        fill_in "comment_body", :with => ""
        click_button "Add Comment"
      end

      it "rendera a new form" do
        current_path.should == "/comments/1/comments"
      end
    end
    context "blank body" do
      before do
        fill_in "comment_body", :with => "Reply to Comment"
        click_button "Add Comment"
      end

      it "renders a new form" do
        current_path.should == "/articles/1"
        page.should have_content("Reply to Comment")
      end
    end
  end
end
