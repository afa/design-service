class ReplanningEndorsement < ActiveRecord::Base
  attr_accessible :developed_by_general_projector, :flat_area, :replanning_organization_licensed
  has_many :replanning_attachments # , class_name: 'ReplanningAttachment', foreign_key: 'replanning_attachment_id'
  accepts_nested_attributes_for :replanning_attachments, allow_destroy: true
  attr_accessible :replanning_attachments_attributes
end
