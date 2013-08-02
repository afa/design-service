class ReplanningEndorsement < ActiveRecord::Base
  has_one :order, as: :orderable
  has_one :client, through: :order
  has_many :replanning_attachments

  # scopes use select not to be readonly
  # .readonly(false) can be used instead
  scope :by_client, ->(client_id) { joins(:order).where(orders: {client_id: client_id} ) }

  def price; order.price; end
  def price=(value); order.update_attribute(:price, value); end

  accepts_nested_attributes_for :replanning_attachments, allow_destroy: true
  def self.generate
    new(developed_by_general_projector: true, replanning_organization_licensed: true)
  end
end