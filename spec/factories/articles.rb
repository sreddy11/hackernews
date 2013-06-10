# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :article do
    sequence(:title) {|n| "article title #{n}"}
    url 'http://cnn.com'
  end

end

