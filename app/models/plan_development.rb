#encoding: utf-8
class PlanDevelopment < ActiveRecord::Base
  has_paper_trail
  has_one :moderation_info, as: :moderable
  has_one :order, as: :orderable
  has_one :client, through: :order
  #belongs_to :comment, class_name: 'ModerableText'
  belongs_to :attachment
  #belongs_to :family_composition, class_name: 'ModerableText'

  scope :by_client, ->(client_id) { joins(:order).where(orders: {client_id: client_id} ) }

  accepts_nested_attributes_for :attachment #, :comment, :family_composition

  def price; order.price; end
  def price=(value); order.update_attribute(:price, value); end

  extend Enumerize
  enumerize :num_guests, in: [:zero, :less_than_five, :five_to_fifteen, :greater_than_fifteen]
  enumerize :big_kitchen, in: [:less_than_fifteen, :greater_than_fifteen]
  enumerize :num_plans, in: [1,2,3,4]

  def full_address
    "#{address} (подъезд: #{section}, этаж: #{floor})"
  end

  def family_composition_first_line
    @family_composition_first_line ||= family_composition
  end
  def family_composition_second_line
    @family_composition_second_line ||= ''
  end

  def family_composition_first_line=(val)
    @family_composition_first_line = val
    self.family_composition = [@family_composition_first_line, @family_composition_second_line].compact.reject(&:blank?).join(' ')
  end
  def family_composition_second_line=(val)
    @family_composition_second_line = val
    self.family_composition = [@family_composition_first_line, @family_composition_second_line].compact.reject(&:blank?).join(' ')
  end
end