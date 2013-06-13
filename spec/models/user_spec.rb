require 'spec_helper'

describe User do
  
  it { should validate_presence_of(:user_name) }
  it { should validate_uniqueness_of(:user_name) }
  it { should validate_presence_of(:password) }
  it { should ensure_length_of(:password).is_at_least(6) }

end
