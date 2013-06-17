require 'spec_helper'

describe ApplicationController do

  describe "#logged_in?" do
    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end
      it "logged_in? method should return false" do
        controller.send(:logged_in?).should == false
      end
    end

    context "user is logged in" do
      before do
        session[:user_id] = 1
      end
      it "logged_in? method should return true" do
        controller.send(:logged_in?).should == true
      end
    end
  end

   describe "current_user" do
    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end
      it "current_user method should return nil" do
        controller.send(:current_user).should == nil
      end
    end

    context "user is logged in" do
      
      let!(:user) { FactoryGirl.create(:user) }
      before do
        session[:user_id] = user.id
      end
      it "current_user method should return user.id" do
        controller.send(:current_user).should == user
      end
    end
  end

end      
    
      


