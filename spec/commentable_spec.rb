require "set"

shared_examples_for "a commentable" do
  
  
  describe "has_children?" do
    
    context " it should return false" do
      it "should return false" do
        commentable.has_children?.should == false
      end
    end

    context "should return true" do

      let(:comment) { FactoryGirl.create(:comment, :commentable => commentable) }

      it "should return true" do
        commentable.has_children?.should == true
      end
    end

  end

  describe "num children" do
    
   context "should be 1" do
    it "returns num_children" do
      commentable.num_children?.should == 0
    end
   end
    
    
    context "should be 1" do
      
      let(:comment) { FactoryGirl.create(:comment, :commentable => commentable) }
      
      it "returns num_children" do
        commentable.num_children?.should == 1  
      end
    end
  end
end
    

