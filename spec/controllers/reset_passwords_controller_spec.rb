require 'spec_helper'

describe ResetPasswordsController do

  let!(:user) { FactoryGirl.create(:user, {:reset_password_token => "anything"}) }
  
  describe "POST to create" do

    before do
      post :create 
    end
    it { should respond_with(:redirect) }
    it { should redirect_to(articles_path)}
  end

  describe "POST to update" do
    before do
      post :update, :id => user.id
    end

    context "Password request expired" do
      it { should respond_with(:redirect) }
      it { should redirect_to(new_reset_password_path) }
    end

    context "Password request no expired" do
      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
    end
      
  end



end
