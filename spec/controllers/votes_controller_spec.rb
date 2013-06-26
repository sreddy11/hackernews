require 'spec_helper'

describe VotesController do

  let!(:article) { FactoryGirl.create(:article) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:comment) { FactoryGirl.create(:comment) }
  

  
  describe "POST to #create" do
    
    context "user not logged in" do
      before do
        session[:user_id] = nil
        post :create, :article_id => article.id 
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(login_path) }

    end

    context "user logged in" do

      before do
        session[:user_id] = user.id
      end

      context "parent is article" do
        before do 
          post :create, :article_id => article.id, :up_or_down => 1
        end

        it "should save" do
          article.votes.count.should == 1
        end
      end


      context "parent is comment" do
        
        context "a vote does not already exist" do
    
          before do 
            post :create, :comment_id => comment.id, :up_or_down => -1
          end

          it "should save" do
            comment.votes.count.should == 1
            comment.votes.first.up_or_down.should == -1
          end
        end
      end
        context "a vote already exists" do
          let!(:vote) {FactoryGirl.create(:vote, {:votable => comment, :up_or_down => -1, :user => user})}

          before do 
            post :create, :comment_id => comment.id, :up_or_down => 1
          end

          it "should save" do
            comment.votes.count.should == 1
            comment.votes.first.up_or_down.should == 1
        end
      end
    end
  end

  describe "DELETE to #destroy" do

    before do
      session[:user_id] = user.id
    end

    context "parent is article" do

      let!(:vote2) { FactoryGirl.create(:vote, {:votable => article, :user=> user}) }
      
      before do 
        delete :destroy, :article_id => article.id
      end

      it "should create then destroy" do
        article.votes(true).count.should == 0
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(article) }
    end


    context "parent is comment" do
    
      let!(:vote2) { FactoryGirl.create(:vote, {:votable => comment, :user => user}) }

      before do 
        delete :destroy, :comment_id => comment.id     
      end

      it "should create then destroy" do
        comment.votes(true).count.should == 0
      end
    end
  end
end


