require 'spec_helper'

describe LoginsController do

  render_views
  
  describe "GET to #new" do

    context "user is logged in" do
      before do
        session[:user_id] = 1
        get :new
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
    end

    context "user is not logged in" do
      before do
        session[:user_id] = nil
        get :new
      end

      it { should respond_with(:success) }
    end

  end

  describe "POST to #create" do
    
   let!(:existing_user) { FactoryGirl.create(:user,{:user_name =>'sreddy1', :password => 'password'}) }

   context "user is logged in" do
      before do
        session[:user_id] = existing_user.id
        post :create
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path)}
   end

   context "user is not logged in" do

     before do
       session[:user_id] = nil
     end

     context "Valid login" do
       before do
         post :create, :login => { :user_name => existing_user.user_name , :password => 'password' }
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
   end

  describe "DELETE to #destroy" do
  
    before do
      session[:user_id] = 1
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
end
