# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    user_name 'sreddy1'
    password 'password'
    password_confirmation 'password'

  end
end
