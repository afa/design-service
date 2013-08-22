class ReplanningEndorsement < ActiveRecord::Base
  include ActsAsOrderable

  def attachment_kinds
    ['plan_of_flat']
  end

  def self.default_params
    {developed_by_general_projector: true,
    replanning_organization_licensed: true}
  end
  def self.generate
    find_or_create_order
  end
  def num_plans; 1; end
end
