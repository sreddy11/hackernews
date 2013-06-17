require 'spec_helper'

describe Article do

  describe "#url_domain" do
    
    let!(:article) { FactoryGirl.create(:article, {:url => 'http://news.com/321321'}) }
    let!(:unparseable_url) { FactoryGirl.create(:article, {:url => 'http://:1234'}) }

    it "checks the domain returns a valid name" do
        article.domain.should == "news.com"
    end
    
    it "domain method URI.parse throws exception" do
      unparseable_url.domain.should == ""
    end

  end
   
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  it { should allow_value('https://cnn.com').for(:url) }
  it { should_not allow_value('not_a_url').for(:url) }

end
