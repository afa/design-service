class SpecialistGroup < ActiveRecord::Base
  belongs_to :specialization
  has_and_belongs_to_many :specialists

  has_many :portfolios
  has_many :portfolio_items, through: :portfolios

  has_one :avatar, as: :imageable_single, class_name: 'Photo'
  has_many :received_messages, as: :recipient, class_name: 'Message'

  has_many :groups_orders, as: :executor, :class_name => 'Order'
  has_many :orders
  # привязка группы к заказу напрямую, не через исполнителя. считать цену и выбирать исплнителей. 
  has_many :reviews, through: :specialists

  def messages; received_messages; end

  extend Enumerize
  #enumerize :specialization, in: [:designer, :architector, :engineer, :building_company, :building_brigade, :not_a_specialist]
  scope :by_specialization, ->(specialization) { where(specialization: specialization) }

#  def positive_feedback; specialists.map(&:positive_feedback).inject(0,&:+); end
#  def negative_feedback; specialists.map(&:negative_feedback).inject(0,&:+); end
#  def neutral_feedback; specialists.map(&:neutral_feedback).inject(0,&:+); end
#  def number_of_completed_orders; specialists.map(&:number_of_completed_orders).inject(0,&:+); end

  def rating;  "#{reliability_rating}/#{quality_rating}"; end
  def to_s; "#{union_name} [#{name}]"; end

  def number_of_participants
    specialists.count
  end

  def union_name
    I18n.t("specialist_groups.union_name.#{specialization || :not_a_specialist}")
  end

  def available_portfolios
    specialists.map(&:portfolios).flatten
  end
end
