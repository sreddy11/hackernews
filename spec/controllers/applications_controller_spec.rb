require 'spec_helper'

describe ApplicationController do

  describe "#logged_in?" do
    context "user is not logged in" do
      
      before do
        session[:user_id] = nil
      end
      
      it "returns false" do
        controller.send(:logged_in?).should == false
      end
    end

    context "user is logged in" do
      before do
        session[:user_id] = 1
      end
      
      it "returns true" do
        controller.send(:logged_in?).should == true
      end
    end
  end

   describe "current_user" do
    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end
      
      it "returns nil" do
        controller.send(:current_user).should == nil
      end
    end

    context "user is logged in" do
      
      let!(:user) { FactoryGirl.create(:user) }
      before do
        session[:user_id] = user.id
      end
      
      it "returns logged in user" do
        controller.send(:current_user).should == user
      end
    end
  end

end      
    
      


