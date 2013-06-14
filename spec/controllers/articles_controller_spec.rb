require 'spec_helper'

describe ArticlesController do

  render_views

  describe "GET to #index" do
    let!(:articles) { [] }
    
    before do
      30.times do |i|
        articles.push(FactoryGirl.create(:article, :updated_at => i.days.ago)) 
      end
      get :index
    end

    it { should respond_with(:success) }
    it "assigns/paginates the articles" do
      assigns[:articles].should == articles[0...20]
    end
    it "gets the next page" do
       assigns[:articles].paginate(:page => 2).should == articles[20...30]
    end

  end

  describe "GET to #show" do
    
    let!(:article) { FactoryGirl.create(:article) }

    before do
      get :show, :id => article.id
    end

    it { should respond_with(:success) }
    it "assigns the article" do
      assigns[:article].should == article
    end
  end
  
  describe "GET to #new" do
     
    let(:user) { FactoryGirl.create(:user) }
   
    context "User is logged in" do

      before do
        session[:user_id] = user.id
        get :new
      end

      it { should respond_with(:success) }
      it "assigns the article" do
        assigns[:article].should_not == nil
      end
    end

    context "User is not logged in" do
      before do
        session[:user_id] = nil
        get :new
      end
 
      it { should respond_with(:redirect) }
      it { should redirect_to(new_login_path) }
    end
  end

  describe "POST to #create" do
    
    context "fields are valid" do
      before do
        session[:user_id] = nil
        get :new 
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(new_login_path) }
    end
  end

  describe "POST to #create" do
    let(:user) { FactoryGirl.create(:user) }

    context "User is logged in" do

      before do 
        session[:user_id] = user.id
      end

      context "fields are valid" do
        before do
          post :create, :article => {:title => "new title", :url => "http://cnn.com"}
        end
        
        it { should respond_with(:redirect) }
        it { should redirect_to(article_path(assigns[:article].id)) }
      end

      context "fields are invalid" do
        before do
          post :create, :article =>{:title => ''}
        end
        
        it { should respond_with(:success) }
        it "Has errors on the article" do
           assigns[:article].errors.any?.should == true
        end
      end
    end

    context "User is not logged in" do

      before do
        session[:user_id] = nil
        get :new 
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(new_login_path) }
    end
  end
end
 


