require 'spec_helper'

describe Article do
  
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  #it { should allow_value('https://cnn.com') }

  #pending "add some examples to (or delete) #{__FILE__}"
end
