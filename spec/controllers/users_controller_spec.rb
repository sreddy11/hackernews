require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET to #show" do
    let!(:user) { FactoryGirl.create(:user) }
    
    before do
      get :show, :id => user.id
    end

    it { should respond_with(:success) }
    
    it "assigns the user" do
      assigns[:user].should == user
    end
  end

  describe "GET to #new" do
     
    before do
      get :new
    end

    it { should respond_with(:success) }
    
    it "assigns the user" do
      assigns[:user].should_not == nil
    end
  end

  describe "POST to #create" do
    
    context "all fields are valid" do
      before do
        post :create, :user => {:user_name => 'sreddy1', :password => 'password', :password_confirmation => 
          'password'}  
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path) }

    end
    
    context "username not valid" do
      before do
        post :create, :user => {:user_name => '', :password => 'password', :password_confirmation => 'password'}
      end
       
      it { should respond_with(:success)}
      it "assigns the user" do
        assigns[:user].errors[:user_name].any?.should == true        
      end
    end

    context "password not valid" do

      before do
        post :create, :user => {:user_name => 'sreddy1', :password => 'pas', :password_confirmation => 'password'}
      end
       
      it { should respond_with(:success)}
      it "assigns the user" do
        assigns[:user].errors[:password].any?.should == true        
      end
    end

    context "password confirmation does not match" do

      before do
        post :create, :user => {:user_name => 'sreddy1', :password => 'password', 
          :password_confirmation => 'password2'}
      end
       
      it { should respond_with(:success)}
      it "assigns the user" do
        assigns[:user].errors.any?.should == true        
      end
    end

    context "username taken" do

      let!(:existing_user) { FactoryGirl.create(:user) }
      before do
        post :create, :user => {:user_name => existing_user.user_name , :password => 'password', 
          :password_confirmation => 'password'}
      end
      it { should respond_with(:success)}
      it "assigns the user" do
        assigns[:user].errors[:user_name].any?.should == true        
      end
    end
  end
end




