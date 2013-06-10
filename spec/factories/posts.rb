# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "post title #{n}"}
    content {"string"}
  end
end
