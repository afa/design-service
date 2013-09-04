class EngineeringSystem < ActiveRecord::Base
  include ActsAsOrderable

  def attachment_kinds
    ['design_project']
  end
  def self.generate
    generate_order do
      orderable.attachments.build
    end
  end

  def self.default_params
    {  }
  end
end
