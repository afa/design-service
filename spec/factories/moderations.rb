# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :moderation do
    moderable nil
    accepted_first_stage false
    accepted_final false
  end
end
