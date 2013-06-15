require 'spec_helper'

describe Article do
  
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  it { should allow_value('https://cnn.com').for(:url) }
  it { should_not allow_value('not_a_url').for(:url) }

end
