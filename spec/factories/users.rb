# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:user_name) {|n| "User#{n}"}
    password 'password'
    password_confirmation 'password'

  end
end
