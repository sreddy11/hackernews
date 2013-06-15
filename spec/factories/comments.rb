# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
  
    sequence(:body) { |n| "Comment #{n}"}
    article
    user


  end
end
