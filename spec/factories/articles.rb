# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :article do
    sequence(:title) {|n| "article title #{n}"}
    sequence(:url) {|n| 'http://cnn.com/' + n.to_s()}
    user
  end  
end    
