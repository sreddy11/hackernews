require "set"

shared_examples_for "a votable" do
  
  it { should have_many(:votes) }

  describe "num_upvotes" do
    
    context "doesn't have any votes" do
      it "should return zero" do
        votable.num_upvotes.should == 0
      end
    end

    context "has votes" do
      let!(:vote) { FactoryGirl.create(:vote, :up_or_down => 1 ,:votable => votable) }

      it "should return true" do
        votable.num_upvotes.should == 1
      end
    end
  end

  describe "num_downvotes" do
    
    context "doesn't have any votes" do
      it "should return zero" do
        votable.num_downvotes.should == 0
      end
    end

    context "has votes" do
      let!(:vote) { FactoryGirl.create(:vote, :up_or_down => -1 ,:votable => votable) }

      it "should return true" do
        votable.num_downvotes.should == 1
      end
    end
  end
end
