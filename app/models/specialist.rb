#encoding: utf-8
class Specialist < ActiveRecord::Base
  before_create :new_user
  has_and_belongs_to_many :specialist_groups
  has_many :orders, as: :executor

  has_many :transactions_inbound, :class_name => 'Transaction', :foreign_key => :destination_id
  has_many :transactions_outbound, :class_name => 'Transaction', :foreign_key => :source_id

  def transactions
   transactions_inbound + transactions_outbound
  end

  belongs_to :user
  has_one :profile, through: :user

  has_many :portfolios, as: :owner
  has_many :portfolio_items, through: :portfolios
  has_one :main_portfolio, as: :owner, class_name: 'Portfolio'

  scope :by_order, ->(order_id) { joins(:orders).where('orders.id' => order_id) }

  delegate :messages,  to: :user
  delegate :full_name, :username, :to_s,  to: :profile
  delegate :avatar, to: :user

  def rating; 666; end
  def rating_count; 777; end
  def positive_feedback; 10; end
  def negative_feedback; 0; end
  def neutral_feedback; 0; end
  def number_of_completed_orders; 7; end

  def description
    "Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!Ололо, я водитель НЛО!"
  end

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
end
