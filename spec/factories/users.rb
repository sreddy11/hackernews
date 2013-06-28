FactoryGirl.define do
  factory :user do

    sequence(:user_name) {|n| "User#{n}"}
    password 'password'
    password_confirmation 'password'
    sequence(:email) {|n| "#{n}@yahoo.com"}
    
    factory :user_with_articles do
      ignore do
        articles_count 5
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:article, evaluator.articles_count, user: user)
      end
    end

  end
end
