class EngineeringSystem < ActiveRecord::Base
  include ActsAsOrderable

  def attachment_kinds
    ['design_project']
  end

  def self.default_params
    {  }
  end
end
