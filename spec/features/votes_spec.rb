require 'spec_helper'

describe "Vote" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:article) { FactoryGirl.create(:article) }

  before do
    login(user)
  end

  context "upvoting" do
    context "article" do
      before do
        visit '/articles/1'
        click_link "Like" 
      end

      it "registers the vote" do
        current_path.should == '/articles/1'
        page.should have_content("Undo My Like")
      end

      context "undo the vote" do
        before do
          click_link "Undo My Like"
        end

        it "undoes the vote" do
          current_path.should == '/articles/1'
          page.should_not have_content("Undo My Like")
        end
      end

      context "switch vote to dislike" do
        before do
          click_link "Dislike"
        end

        it "switches the vote to dislike" do
          current_path.should == '/articles/1'
          page.should have_content("Undo My Dislike")
        end

        context "undo the vote" do
          before do
            click_link "Undo My Dislike"
          end

          it "undoes the vote" do
            current_path.should == '/articles/1'
            page.should_not have_content("Undo My Dislike")
          end
        end
      end
    end
  end
end
