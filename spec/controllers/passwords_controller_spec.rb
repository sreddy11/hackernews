require 'spec_helper'

describe PasswordsController do

  render_views

  let!(:user) { FactoryGirl.create(:user, {:reset_password_token => "token", :reset_password_sent_at => Time.now})}
  
  describe "POST to create" do
   context "valid email" do
      before do
        post :create, :email => user.email 
      end
      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
      it "checks the flash" do
        flash[:notice].should == "E-mail has been sent regarding resetting password."
      end
   end

   context "valid email" do
      before do
        post :create, :email => "112" 
      end
      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
      it "checks the flash" do
        flash[:notice].should == "No account matches the e-mail provided."
      end
   end
  end

  describe "PUT to update" do

    context "Password request expired" do
      
      before do
        user.update_attribute(:reset_password_sent_at, 5.hours.ago)
        put :update, :token => user.reset_password_token, 
          :user => {:password => "password", :password_confirmation => "password"}
      end
      it { should respond_with(:redirect) }
      it { should redirect_to(new_password_path) }
      it "checks the flash" do
        flash[:alert].should == "Password reset has expired."
      end
    end

    context "Password request no expired" do

      before do
        put :update, :token => user.reset_password_token,
          :user => { :password => "password", :password_confirmation => "password"}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
      it "checks the flash" do
        flash[:notice].should == "Password has been reset!"
      end
    end
  end
end
