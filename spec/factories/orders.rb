# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    work_state 'draft'
    payment_state 'not_paid'
    orderable nil
    client nil
    completion_status "MyString"
  end
end
