require 'spec_helper'

describe Comment do

 it { should validate_presence_of(:username) }
 it { should validate_presence_of(:body) }
 
 it { should belong_to(:post) }

end
