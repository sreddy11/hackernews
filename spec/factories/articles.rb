FactoryGirl.define do

  factory :article do
    sequence(:title) {|n| "article title #{n}"}
    sequence(:url) {|n| "http://cnn.com/#{n}"}
    user
  end  
end    
