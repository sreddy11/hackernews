require 'spec_helper'

describe CommentsController do

  render_views

  let!(:new_article) { FactoryGirl.create(:article) }
  let!(:comment) { FactoryGirl.create(:comment, :article => new_article) }
  let!(:parent) { FactoryGirl.create(:comment) }

  describe "GET to #index" do
          
    context "parent is article" do 
      before do
        get :index, :article_id => new_article.id
      end

      it { should respond_with(:success) }
      it "assigns the comment" do
        assigns[:comments] = [comment]
      end
    end

    context "parent is comment" do

      before do
        get :index, :comment_id => parent.id
      end

      it { should respond_with(:success) }
      it "assigns the comment" do
        assigns[:comments] = [comment]
      end
    end

  end

   describe "Get to #show" do
    
    context "parent is article" do 
      before do
        get :show, :article_id => new_article.id,  :id => comment.id
      end
      
      it "assigns the comment" do
        assigns[:comment].should == comment
      end
    end

    context "parent is comment" do
      let!(:comment2) { FactoryGirl.create(:comment, :commentable => parent) }
      before do
        get :show, :comment_id => parent.id,  :id => comment2.id
      end
      
      it { should respond_with(:success) }

      it "assigns the comment" do
        assigns[:comment].should == comment2
      end

    end
  end

  describe "Get to #new" do
    
    context "parent is article" do
      
      context "user not logged in" do
       before do
          session[:user_id] = nil
          get :new, :article_id => new_article.id 
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(login_path) }
      end
      
      
      context "user logged in" do
        before do
          session[:user_id] = 1
          get :new, :article_id => new_article.id
        end
      
        it { should respond_with(:success) }
 
        it "assigns the comment" do
          assigns[:comment].should_not == nil
        end
      end
    end

    context "parent is comment" do
      
      context "user not logged in" do
       before do
          session[:user_id] = nil
          get :new, :comment_id => parent.id 
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(login_path) }
      end
      
      
      context "user logged in" do
        before do
          session[:user_id] = 1
          get :new, :comment_id => parent.id
        end
      
        it { should respond_with(:success) }

        it "assigns the comment" do
          assigns[:comment].should_not == nil
        end
      end
    end
end

  describe "Post to #create" do
   
    context "parent is article" do
      context "user not logged in" do
        before do
          session[:user_id] = nil
          post :create , :article_id => new_article.id 
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(login_path) }
   
      end
      
      context "comment not blank" do
        before do
          session[:user_id] = 1
          post :create, :article_id => new_article.id, :comment => {:body => "new comment"}
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(article_path(assigns[:comment].article.id)) }
      end

      context "comment is blank" do
        before do
          session[:user_id] = 1
          post :create, :article_id => new_article.id
        end
        it { should respond_with(:success) }
        it "Has errors on the comment" do
           assigns[:comment].errors[:body].any?.should == true
        end
      end
    end

    context "parent is comment" do
      context "user not logged in" do
        before do
          session[:user_id] = nil
          post :create , :comment_id => comment.id 
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(login_path) }
   
      end
      
      context "comment not blank" do
        before do
          session[:user_id] = 1
          post :create, :comment_id => parent.id, :comment => {:body => "new comment"}
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(comment_path(assigns[:comment].parent.id)) }
      end

      context "comment is blank" do
        before do
          session[:user_id] = 1
          post :create, :comment_id => comment.id
        end
        it { should respond_with(:success) }
        it "Has errors on the comment" do
           assigns[:comment].errors[:body].any?.should == true
        end
      end
    end



  end
end
