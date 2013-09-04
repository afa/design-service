class ReplanningEndorsement < ActiveRecord::Base
  include ActsAsOrderable

  def attachment_kinds
    ['plan_of_flat']
  end

  def self.default_params
    {developed_by_general_projector: true,
    replanning_organization_licensed: true}
  end
end
