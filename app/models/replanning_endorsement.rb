class ReplanningEndorsement < ActiveRecord::Base
  has_one :order, as: :orderable
  has_one :client, through: :order

  has_many :replanning_attachments # , class_name: 'ReplanningAttachment', foreign_key: 'replanning_attachment_id'
  accepts_nested_attributes_for :replanning_attachments, allow_destroy: true
end