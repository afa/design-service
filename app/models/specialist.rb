# coding: utf-8
class Specialist < ActiveRecord::Base
  self.per_page = 20

  before_create :new_user
  has_and_belongs_to_many :specialist_groups
  has_many :orders, as: :executor

  has_many :reviews, through: :orders

  belongs_to :user, include: :profile

  has_many :specializations, through: :specialist_groups
  has_one :profile, through: :user

  has_many :portfolios
  has_many :portfolio_items, through: :portfolios

  belongs_to :specialization, class_name: 'Specialization', foreign_key: 'specialization_id'

  has_many :request_specialists
  has_many :join_request_specialists, class_name: 'RequestSpecialist', foreign_key: 'join_specialist'

  scope :by_order, ->(order_id) { joins(:orders).where('orders.id' => order_id) }

  delegate :messages,  to: :user
  delegate :full_name, :to_s,  to: :profile
  delegate :username, to: :user
  delegate :avatar, to: :user
  delegate :qiwi, :transactions, to: :user

  # def rating; 666; end
  # def rating_count; 777; end
  # def positive_feedback; 10; end
  # def negative_feedback; 0; end
  # def neutral_feedback; 0; end
  # def number_of_completed_orders; 7; end

  # def description
  #   "Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!"
  # end

  def new_user
    return if user
    build_user do |u|
      u.new_profile
    end
  end
  def self.new_specialist(options = {})
    new(options) do |sp|
      sp.build_user do |u|
        u.new_profile
      end
    end
  end
  def number_of_completed_orders
    orders.where(work_state: :work_accepted).count
  end
  def as_json(options={})
    {id: id, full_name: full_name, specializations: specializations}
  end

  def get_bunch_on_filter(page, filter)
    Specialist.paginate(:page => page)
      .order("specialists.created_at desc")
  end

  def count_specialists(filter)
    Specialist.count
  end

  def get_first_group
    SpecialistGroup\
      .joins("inner join specialist_groups_specialists on specialist_groups_specialists.specialist_group_id = specialist_groups.id")\
      .where("specialist_groups_specialists.specialist_id = ?", self.id).first
  end
end
