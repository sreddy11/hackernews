require 'spec_helper'

describe ArticlesController do

  render_views

  describe "GET to #index" do
    
    let!(:articles) { [FactoryGirl.create(:article)] }
    
    before do
      get :index
    end

    it { should respond_with(:success) }
    it "assigns the article" do
      assigns[:articles].should == articles
    end
  end

  describe "GET to #show" do
    
    let!(:article) { FactoryGirl.create(:article) }

    before do
      get :show, :id => article.id
    end

    it { should respond_with(:success) }
    it "Assigns the article" do
      assigns[:article].should == article
    end
  end
  
  describe "GET to #new" do
     
    before do
      get :new
    end

    it { should respond_with(:success) }
    it "assigns the article" do
      assigns[:article].should_not == nil
    end
  end


  describe "POST to #create" do
    
    context "fields are valid" do
      
      before do
        post :create, :article => {:title => "new title", :url => "http://cnn.com"}
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(articles_path) }
    end

    context "fields are invalid" do
      before do
        post :create
      end
      it { should respond_with(:success) }
      it "Has errors on the post" do
         assigns[:article].errors.any?.should == true
      end
    end
  end

 

end

