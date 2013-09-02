# Order of not specified type (typically is created from message or by phone call). So this class is a brother of PlanDevelopment et.al.
class OrderToSpecialist < ActiveRecord::Base
  include ActsAsOrderable
end
