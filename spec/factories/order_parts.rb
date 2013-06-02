# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_part do
    order nil
    status "MyString"
  end
end
