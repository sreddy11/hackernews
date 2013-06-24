require 'spec_helper'

describe UpvotesController do

  let!(:new_article) { FactoryGirl.create(:article) }
  let!(:upvote) { FactoryGirl.create(:vote) }
  let!(:parent) { FactoryGirl.create(:comment) }
  let!(:user) { FactoryGirl.create(:user) }


  
  describe "POST to #create" do
    
    context "user not logged in" do
        before do
          session[:user_id] = nil
          post :create, :article_id => new_article.id 
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(login_path) }

    end

    context "user logged in" do

      context "parent is article" do

          before do 
            session[:user_id] = user.id
            post :create, :article_id => new_article.id
          end

          it "should save" do
            new_article.votes.count.should == 1
          end
      end


      context "parent is comment" do
    
        before do 
          session[:user_id] = user.id
          post :create, :comment_id => parent.id
        end

        it "should save" do
          parent.votes.count.should == 1
        end
      end
    end
  end

  describe "DELETE to #destroy" do

    context "parent is article" do

        before do 
          session[:user_id] = user.id
          post :create, :article_id => new_article.id
          delete :destroy, :article_id => new_article.id
        end

        it "should create then destroy" do
          new_article.votes.count.should == 0
        end
    end


    context "parent is comment" do
    
      before do 
        session[:user_id] = user.id
        post :create, :comment_id => parent.id
        delete :destroy, :comment_id =>parent.id
      end

      it "should create then destroy" do
        parent.votes.count.should == 0
      end
    end
  end
end


