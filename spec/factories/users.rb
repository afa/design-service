# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
   "a#{n}@a.a"
  end
  sequence :uname do |n|
   "user#{n}"
  end
  factory :user do
   username {generate(:uname)}
   email { generate(:email) }
   password '11111111'
  end
end
