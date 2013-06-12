require 'spec_helper'

describe LoginsController do

  render_views
  
  describe "GET to #new" do

    before do
      get :new
    end

    it { should respond_with(:success) }
  end

  describe "POST to #create" do
    
   let!(:existing_user) { FactoryGirl.create(:user) }
    
   context "Valid login" do
     before do
       post :create, :login => { :user_name => 'sreddy1', :password => 'password' }
     end

     it { should respond_with(:redirect) }
     it { should redirect_to(articles_path) }
     it "has login succes" do
       flash[:notice].should == "Login Successful"
     end
     it "session saved" do
       session[:user_id].should == existing_user.id
     end

    end

    context "Username not in database"  do 
      before do
        post :create, :login => { :user_name => 'sreddy2', :password => 'password' }
      end

      it { should respond_with(:success) }
      it "Has errors on the login" do
         flash[:error].should == "Login Invalid"
      end
    end

    context "Password does not match what exists in database"  do 
      before do
        post :create, :login => { :user_name => 'sreddy1', :password => 'password2' }
      end

      it { should respond_with(:success) }
      it "Has errors on the login" do
         flash[:error].should == "Login Invalid"
      end
    end

   
   end

  describe "DELETE to #destroy" do
  
    before do
      post :create, :login => { :user_name => 'sreddy1', :password => 'password' }
    end
    
    context "Delete successful" do
      before do
        delete :destroy      
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path) }

      it "has logout success" do
        flash[:notice].should == "Logout Successful"
      end
      it "session reset" do
        session[:user_id].should == nil
      end

      
    end
  
    context "Delete not successful" do

      let!(:existing_user) { FactoryGirl.create(:user) }

      
      before do
        post :create, :login => { :user_name => 'sreddy1', :password => 'password' }
        delete :destroy
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path) }
      it "has logout failure" do
        flash[:error].should == "Logout Not Successful"
      end
      it "session reset" do
        session[:user_id].should == existing_user.id
      end



      
    end

  end


  
  

end
