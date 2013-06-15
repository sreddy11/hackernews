require 'spec_helper'

describe CommentsController do

  render_views

  let!(:new_article) { FactoryGirl.create(:article) }
  let!(:comment) { FactoryGirl.create(:comment, :article => new_article) }

  describe "GET to #index" do
          
    before do
      get :index, :article_id => new_article.id
    end

     it { should respond_with(:success) }
     it "assigns the comment" do
       assigns[:comments] = [comment]
     end 
  end

   describe "Get to #show" do
    before do
      get :show, :article_id => new_article.id,  :id => comment.id
    end
    
    it { should respond_with(:success) }

    it "assigns the comment" do
      assigns[:comment].should == comment
    end
  end

  describe "Get to #new" do
    before do
      get :new, :article_id => new_article.id
    end
  
    it { should respond_with(:success) }

    it "assigns the comment" do
      assigns[:comment].should_not == nil
    end
  end

  describe "Post to #create" do
    context "comment not blank" do
      before do
        post :create, :article_id => new_article.id, :comment => {:body => "new comment"}
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(article_path(assigns[:comment].article.id)) }
    end

    context "comment is blank" do
      before do
        post :create, :article_id => new_article.id 

      end
      it { should respond_with(:success) }
      it "Has errors on the comment" do
         assigns[:comment].errors[:body].any?.should == true
      end
    end
  end
end
