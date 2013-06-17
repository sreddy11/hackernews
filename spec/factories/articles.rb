FactoryGirl.define do

  factory :article do
    sequence(:title) {|n| "article title #{n}"}
    url 'http://cnn.com'
    user
  end  
end    
