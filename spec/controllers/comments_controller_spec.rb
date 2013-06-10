require 'spec_helper'

describe CommentsController do

  let!(:blog_post) { FactoryGirl.create(:post) }
  
  let!(:comment) { FactoryGirl.create(:comment, :post => blog_post) }
  
  describe "Get to #index" do
    before do
      get :index, :post_id => blog_post.id
    end

    it { should respond_with(:success) }

    it "assigns the comments" do
      assigns[:comments].should == [comment]
    end
  end

  describe "Get to #show" do
    before do
      get :show, :post_id => blog_post.id,  :id => comment.id
    end
    
    it { should respond_with(:success) }

    it "assigns the comment" do
      assigns[:comment].should == comment
    end
  end

  describe "Get to #new" do
    before do
      get :new, :post_id => blog_post.id
    end
  
    it { should respond_with(:success) }

    it "assigns the comment" do
      assigns[:comment].should_not == nil
    end
  end

  describe "Get to #edit" do
    
    before do
      get :edit, :post_id => blog_post.id, :id => comment.id
    end

    it { should respond_with(:success) }
    it "assigns the comment" do
      assigns[:comment].should == comment
    end

  end

 describe "Put to #update" do

    context "fields are valid" do
      before do
        put :update, :post_id => blog_post.id , :id => comment.id, :comment=> {:username => "newuser", :body => "updated content"}
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(post_path(assigns[:comment].post.id)) }
    end

    context "fields are not valid" do
      before do
        put :update, :post_id => blog_post.id, :id => comment.id, :comment => {:username => ""}
      end

      it {should respond_with(:success) }
      it "Has any errors" do
          assigns[:comment].errors.any?.should == true
      end
    end

  end


  


  describe "Post to #create" do
    context "fields are valid" do
      before do
        post :create, :post_id => blog_post.id, :comment => {:username => " newuser ", :body => "createdd content"}
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(post_path(assigns[:comment].post.id)) }
    end

    context "fields are invalid" do
      before do
        post :create, :post_id => blog_post.id 

      end
      it { should respond_with(:success) }
      it "Has errors on the comment" do
         assigns[:comment].errors.any?.should == true
      end
    end
  end

  describe "Delete to #delete do" do

    before do
      delete :destroy, :post_id => blog_post.id, :id => comment.id
    end

    it { should respond_with(:redirect) }
    it { should redirect_to(post_path(assigns[:comment].post)) }
  end


  end
