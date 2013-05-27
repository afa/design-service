class SpecialistGroup < ActiveRecord::Base
  has_many :specialists
  has_many :portfolio_items, through: :specialists
  has_one :avatar, as: :imageable_single, class_name: 'Photo'
  has_many :received_messages, as: :recipient, class_name: 'Message'
  def messages; received_messages; end

  scope :by_specialization, ->(specialization) { joins(:specialists).where(specialists: {specialization: specialization }) }

  def positive_feedback; specialists.map(&:positive_feedback).inject(0,&:+); end
  def negative_feedback; specialists.map(&:negative_feedback).inject(0,&:+); end
  def number_of_completed_orders; specialists.map(&:number_of_completed_orders).inject(0,&:+); end
end
