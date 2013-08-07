class ReplanningEndorsement < ActiveRecord::Base
  include ActsAsOrderable

  has_many :attachments, as: :attachable, class_name: 'Attachment'

  accepts_nested_attributes_for :attachments, allow_destroy: true
  def self.default_params
    {developed_by_general_projector: true,
    replanning_organization_licensed: true}
  end
  def self.generate
    new(default_params)
  end
end
