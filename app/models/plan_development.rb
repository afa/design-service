#encoding: utf-8
class PlanDevelopment < ActiveRecord::Base
  has_one :order, as: :orderable
  has_one :client, through: :order
  def price; order.price; end
  def price=(value); order.update_attribute(:price, value); end

  belongs_to :comment, class_name: 'ModerableText'
  belongs_to :attachment
  belongs_to :family_composition, class_name: 'ModerableText'

  accepts_nested_attributes_for :attachment, :comment, :family_composition

  #validates :num_guests, numericality: true
  #validates :num_builtin_closets, numericality: true

  NUM_GUESTS = ["Нет", "До 5", "5-15", "Более 15"].map.with_index{|value,index| [index,value]}
  KITCHEN_SIZE = [[true, 'Больше 15 кв.м.<br/>'.html_safe],[false, 'Меньше 15 кв.м.']]

  def full_address
    "#{address} (подъезд: #{section}, этаж: #{floor})"
  end
end