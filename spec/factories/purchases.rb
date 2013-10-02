# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
   #after_build {|user| user.send(:initialize_state_machines, :dynamic => :force) }
  end
end
