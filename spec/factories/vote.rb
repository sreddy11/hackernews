FactoryGirl.define do
  factory :vote do
    user
    up_or_down 1  
  end
end
