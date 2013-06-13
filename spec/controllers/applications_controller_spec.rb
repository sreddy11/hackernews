require 'spec_helper'

describe ApplicationController do

  describe "#logged_in?" do
    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end
      it "test the method" do
        controller.send(:logged_in?).should == false
      end
    end

    context "user is logged in" do
      before do
        session[:user_id] = 1
      end
      it "tests the method" do
        controller.send(:logged_in?).should == true
      end
    end
  end

   describe "current_user" do
    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end
      it "test the method" do
        controller.send(:current_user).should == nil
      end
    end

    context "user is logged in" do
      
      let!(:user) { FactoryGirl.create(:user) }
      before do
        session[:user_id] = user.id
      end
      it "tests the method" do
        controller.send(:current_user).should == user
      end
    end
  end

end      
    
      


