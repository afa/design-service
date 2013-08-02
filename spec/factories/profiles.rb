# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    name "MyString"
    surname "MyString"
    middlename "MyString"
    fake_name "MyString"
    user nil
  end
end
