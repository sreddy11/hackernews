require 'spec_helper'

describe Vote do

  it { should belong_to(:user) }
  it { should allow_value(1).for(:up_or_down) }
  it { should allow_value(-1).for(:up_or_down) }
  it { should_not allow_value(0).for(:up_or_down) }

end
