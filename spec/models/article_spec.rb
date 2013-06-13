require 'spec_helper'

describe Article do

  describe "#url_domain" do
    let!(:articles) { [] }
    before do
      30.times do |i|
        articles.push(FactoryGirl.create(:article))
      end
      #get :index
    end

    it "checks the domain" do
      articles.each do |article|
        article.domain.should == "cnn.com"
      end
    end
  end
   
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  #it { should allow_value('https://cnn.com') }

  #pending "add some examples to (or delete) #{__FILE__}"
end
