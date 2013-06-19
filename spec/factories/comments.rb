# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    sequence(:body) { |n| "Comment #{n}"}
    user
    commentable_id  1
    commentable_type "Article"
  end
end
