require 'spec_helper'

describe Vote do

  it { should belong_to(:user) }
  context "tests one_or_neg_one" do
    let!(:valid) { FactoryGirl.build(:vote, {:up_or_down => 1}) }
    let!(:valid2) { FactoryGirl.build(:vote, {:up_or_down => -1}) }
    let!(:invalid) { FactoryGirl.build(:vote, {:up_or_down => 0}) }
    
    it "should have errors" do
      invalid.one_or_neg_one.should == false
    end

    it "should have no errors" do
      valid.one_or_neg_one.should == true
      valid2.one_or_neg_one.should == true
    end
  
  end
end
