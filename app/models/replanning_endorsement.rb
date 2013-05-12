class ReplanningEndorsement < ActiveRecord::Base
  has_one :order, as: :orderable
  has_one :client, through: :order
  def price; order.price; end
  def price=(value); order.update_attribute(:price, value); end

  has_many :replanning_attachments # , class_name: 'ReplanningAttachment', foreign_key: 'replanning_attachment_id'
  accepts_nested_attributes_for :replanning_attachments, allow_destroy: true
end