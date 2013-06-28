require 'spec_helper'

describe "Article ratings" do

  let!(:article) { FactoryGirl.create(:article) }

  before do
    visit '/ratings'
  end
  describe "filter by year" do
    
    before do
      select "Year", :from => "filter"
    end
    
    context "1 result" do
      before do
        select Date.today.year, :from => "filter_date_year"
        click_button "Search"
      end
      
      it "should return the article" do
        page.should have_content(article.title)
      end
    end

    context "1 result" do
      before do
        select 1.year.ago.year, :from => "filter_date_year"
        click_button "Search"
      end
      
      it "should return the article" do
        page.should_not have_content(article.title)
      end
    end


  end

  describe "filter by month" do
    before do
      select "Month", :from => "filter"
      select Date.today.year, :from => "filter_date_year"
    end 
    context "1 result" do
      before do
        select Date.today.strftime("%B"), :from => "filter_date_month"
        click_button "Search"
      end
      
      it "should return the article" do
        page.should have_content(article.title)
      end
    end

    context "1 result" do
      before do
        select 1.month.ago.strftime("%B"), :from => "filter_date_month"
        click_button "Search"
      end
      
      it "should return the article" do
        page.should_not have_content(article.title)
      end
    end
  end
  
  describe "filter by day" do
    before do
      select "Day", :from => "filter"
      select Date.today.year, :from => "filter_date_year"
      select Date.today.strftime("%B"), :from => "filter_date_month"
    end
    
    context "1 result" do
      before do
        select Date.today.day, :from => "filter_date_day"
        click_button "Search"
      end
      
      it "should return the article" do
        page.should have_content(article.title)
      end
    end

    context "1 result" do
      before do
        select 1.day.ago.day, :from => "filter_date_day"
        click_button "Search"
      end
      
      it "should return the article" do
        page.should_not have_content(article.title)
      end
    end
  end
end
