#encoding: utf-8
class Specialist < ActiveRecord::Base
  belongs_to :specialist_group

  extend Enumerize
  enumerize :specialization, in: [:designer, :architector, :engineer, :building_company, :building_brigade, :not_a_specialist]

  belongs_to :profile, class_name: 'User'
  has_many :portfolio_items, include: :photo_collection

  has_and_belongs_to_many :orders, class_name: 'Order', join_table: 'order_executors'

  scope :by_specialization, ->(specialization) { where(specialization: specialization) }
  scope :by_order, ->(order_id) { joins(:orders).where('orders.id' => order_id) }

  delegate :full_name, :to_s, :messages,  to: :profile

  def rating; 666; end
  def rating_count; 777; end
  def positive_feedback; 10; end
  def negative_feedback; 0; end
  def neutral_feedback; 0; end
  def number_of_completed_orders; 7; end

  def description
    "Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!"
  end
end