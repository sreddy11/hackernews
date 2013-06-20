require "set"

shared_examples_for "a commentable" do
  
  describe "has_children?" do
    
    context "should not have any comment" do
      it "should return false" do
        commentable.has_children?.should == false
      end
    end

    context "has comments" do
      let!(:comment) { FactoryGirl.create(:comment, :commentable => commentable) }

      it "should return true" do
        commentable.has_children?.should == true
      end
    end
  end

  describe "num children" do
    context "has no child" do
     it "should return 0" do
       commentable.num_children?.should == 0
     end
    end
    
    context "has a child" do
      let!(:comment) { FactoryGirl.create(:comment, :commentable => commentable) }
      let!(:nested_comment) { FactoryGirl.create(:comment, :commentable => comment) } 
      
      it "original comment/article should have 1 child" do
        commentable.num_children?.should == 1  
      end

      it "created comment should have nested comment" do
        comment.num_children?.should == 1
      end
    end
  end
end
    

