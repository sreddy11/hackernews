require 'spec_helper'

describe PasswordsController do

  render_views

  let!(:user) { FactoryGirl.create(:user, {:reset_password_token => "token", :reset_password_sent_at => Time.now})}
  
  describe "POST to create" do

    before do
      post :create, :email => user.email 
    end
    it { should respond_with(:redirect) }
    it { should redirect_to(articles_path)}
  end

  describe "PUT to update" do

    context "Password request expired" do
      
      before do
        user.reset_password_sent_at = 5.hours.ago
        user.save
        put :update, :token => user.reset_password_token, 
          :user => {:password => "password", :password_confirmation => "password"}
      end
      it { should respond_with(:redirect) }
      it { should redirect_to(new_password_path) }
    end

    context "Password request no expired" do

      before do
        put :update, :token => user.reset_password_token,
          :user => { :password => "password", :password_confirmation => "password"}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
    end
      
  end



end
