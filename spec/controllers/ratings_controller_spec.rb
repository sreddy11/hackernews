require 'spec_helper'

describe RatingsController do

  describe "GET to #index" do
  
    context "filtered by year" do
      let!(:article) {FactoryGirl.create(:article, {:created_at => DateTime.new(2012,5,5)})} 
      let!(:article2) {FactoryGirl.create(:article, {:created_at => DateTime.new(2013,5,5)})}

      before do
        get :index, {:filter => "Year", :filter_date => {:year => 2012, :month => 5, :day => 5}}
      end

      it "should retrieve one article" do
        assigns[:ratings].should == [article]
      end
    
    end

    context "filtered by month" do

      let!(:article) {FactoryGirl.create(:article, {:created_at => DateTime.new(2013,6,5)})} 
      let!(:article2) {FactoryGirl.create(:article, {:created_at => DateTime.new(2013,5,5)})}

      before do
        get :index, {:filter => "Month", :filter_date => {:year => 2013, :month => 6, :day => 5}}
      end

      it "should retrieve one article" do
        assigns[:ratings].should == [article]
      end

    
    end

    context "filtered by day" do

      let!(:article) {FactoryGirl.create(:article, {:created_at => DateTime.new(2013,6,5)})} 
      let!(:article2) {FactoryGirl.create(:article, {:created_at => DateTime.new(2013,6,6)})}

      before do
        get :index, {:filter => "Day", :filter_date => {:year => 2013, :month => 6, :day => 5}}
      end

      it "should retrieve one article" do
        assigns[:ratings].should == [article]
      end
    
    end
  
  end

end
