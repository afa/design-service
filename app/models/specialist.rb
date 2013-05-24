#encoding: utf-8
class Specialist < ActiveRecord::Base
  belongs_to :specialist_group

  extend Enumerize
  enumerize :specialization, in: [:designer, :architector, :engineer, :building_company, :building_brigade, :not_a_specialist]

  belongs_to :profile, class_name: 'User'
  #has_many :portfolio_photos
  has_and_belongs_to_many :users_liked, class_name: 'User', join_table: 'specialist_likes'
  has_and_belongs_to_many :orders, class_name: 'Order', join_table: 'order_executors'

  scope :by_specialization, ->(specialization) { where(specialization: specialization) }
  scope :by_order, ->(order_id) { joins(:orders).where('orders.id' => order_id) }

  #accepts_nested_attributes_for :portfolio_photos, allow_destroy: true

  delegate :full_name, :to_s, :messages,  to: :profile

  def rating; 666; end
  def rating_count; 777; end
  def positive_feedback; 10; end
  def negative_feedback; 0; end
  def number_of_completed_orders; 7; end

  def description
    "Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!"
  end

  # def orders_in_portfolio_by_category(category)
    # portfolio_by_category(category).first(2)
  # end

  def like_from?(user)
    users_liked.where(id: user.id).count > 0
  end
  def set_like_from(user)
    return false  if profile == user
    return false  if like_from?(user)
    users_liked << user
  end
  def delete_like_from(user)
    users_liked.delete(user)
  end

  def toggle_like_from(user)
    if like_from?(user)
      delete_like_from(user)
    else
      set_like_from(user)
    end
  end
  def number_of_likes
    users_liked.count
  end
end