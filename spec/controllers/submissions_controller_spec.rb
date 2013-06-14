require 'spec_helper'

describe SubmissionsController do

  describe "GET to #index" do
     
    let!(:user) { FactoryGirl.create(:user_with_articles) }

    before do
      get :index, :user_id => user.to_param
    end

    it { should respond_with(:success) }
    it "assigns the submission" do
      assigns[:submissions].should == user.articles.order("updated_at DESC")
    end
  end


end
