#encoding: utf-8
class Specialist < ActiveRecord::Base
  belongs_to :profile, class_name: 'User'
  has_many :portfolio_photos
  has_and_belongs_to_many :users_liked, class_name: 'User', join_table: 'specialist_likes'
  has_and_belongs_to_many :orders, class_name: 'Order', join_table: 'order_executors'

  scope :by_specialist_type, ->(specialist_type) { where(specialist_type: SPECIALIST_TYPE_ID_BY_NAME[specialist_type]) }
  scope :by_order, ->(order_id) { joins(:orders).where('orders.id' => order_id) }

  accepts_nested_attributes_for :portfolio_photos, allow_destroy: true

  SPECIALIST_TYPE_ID_BY_NAME = Hash[ ["designers", "architectors", "engineers", "building_companies", "building_brigades"].map.with_index{|value,index| [value, index]} ]
  SPECIALIST_TYPE_NAME_BY_TYPE_ID = SPECIALIST_TYPE_ID_BY_NAME.invert

  delegate :full_name, :to_s, to: :profile

  def rating
    666
  end
  def rating_count
    777
  end
  def positive_feedback
   '100500'
  end
  def negative_feedback
    '0'
  end

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