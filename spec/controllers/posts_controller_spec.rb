require 'spec_helper'

describe PostsController do
  
  describe "GET to #index" do
    let!(:posts) { [FactoryGirl.create(:post)] }
    
    before do
      get :index
    end

    it { should respond_with(:success) }
    it "assigns the post" do
      assigns[:posts].should == posts
    end
  end

  describe "Get to #show" do
    let!(:post) { FactoryGirl.create(:post) }

    before do
      authenticate
      get :show, :id => post.id
    end

    it { should respond_with(:success) }
    it "assigns the post" do
      assigns[:post].should == post
    end
  end

  describe "Get to #new" do
     
    before do
      authenticate
      get :new
    end

    it { should respond_with(:success) }
    it "assigns the post" do
      assigns[:post].should_not == nil
    end
  end

  describe "Post to #create" do
    context "fields are valid" do
      before do
        authenticate
        post :create, :post => {:title => "new title", :content => "created content"}
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(post_path(assigns[:post].id)) }
    end

    context "fields are invalid" do
      before do
        authenticate
        post :create
      end
      it { should respond_with(:success) }
      it "Has errors on the post" do
         assigns[:post].errors.any?.should == true
      end
    end

  end

  describe "Get to #edit" do
    let!(:post) { FactoryGirl.create(:post) }
    
    before do
      authenticate
      get :edit, :id => post.id
    end

    it { should respond_with(:success) }
    it "assigns the post" do
      assigns[:post].should == post
    end

  end
  
  describe "Put to #update" do
    let!(:post) { FactoryGirl.create(:post) }

    context "fields are valid" do
      before do
        authenticate
        put :update, :id =>post.id, :post=> {:title => "updated title", :content => "updated content"}
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(post_path(post.id)) }
    end

    context "fields are not valid" do
      before do
        authenticate
        put :update, :id => post.id, :post => {:title => ""}
      end

      it {should respond_with(:success) }
      it "Has any errors" do
          assigns[:post].errors.any?.should == true
      end
    end

  end

  describe "Delete to #delete do" do
    let!(:post) { FactoryGirl.create(:post) }

    before do
      authenticate
      delete :destroy, :id => post.id
    end

    it { should respond_with(:redirect) }
    it { should redirect_to(posts_path) }
  end


end
