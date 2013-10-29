class SpecialistGroup < ActiveRecord::Base
  belongs_to :specialization
  has_and_belongs_to_many :specialists

  has_many :portfolios
  has_many :portfolio_items, through: :portfolios

  #has_one :avatar, as: :imageable_single, class_name: 'Photo'
  mount_uploader :avatar, PhotoUploader
  has_many :received_messages, as: :recipient, class_name: 'Message'

  has_many :groups_orders, as: :executor, :class_name => 'Order'
  has_many :orders
  has_many :selected_forms, through: :orders, source: :orderable, source_type: 'SelectedForm'
  # привязка группы к заказу напрямую, не через исполнителя. считать цену и выбирать исплнителей. 
  has_many :reviews, through: :specialists

  def messages; received_messages; end

  extend Enumerize
  #enumerize :specialization, in: [:designer, :architector, :engineer, :building_company, :building_brigade, :not_a_specialist]
  scope :by_specialization, ->(spec) { where(specialization_id: Specialization.where(:name => spec).first.try(:id)) }

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
    I18n.t("specialist_groups.union_name.#{specialization.try(:name) || :not_a_specialist}")
  end

  def available_portfolios
    specialists.map(&:portfolios).flatten
  end
  def as_json(options={})
    {id: id, name: name, specialization_id: specialization_id}
  end
  def order_customizer
    OrderCustomizer.by_specialization(specialization.full_name)
  end
end
