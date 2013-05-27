class SpecialistGroup < ActiveRecord::Base
  has_many :specialists
  has_many :portfolio_items, through: :specialists

  scope :by_specialization, ->(specialization) { joins(:specialists).where(specialists: {specialization: specialization }) }

  def positive_feedback; specialists.map(&:positive_feedback).inject(0,&:+); end
  def negative_feedback; specialists.map(&:negative_feedback).inject(0,&:+); end
  def number_of_completed_orders; specialists.map(&:number_of_completed_orders).inject(0,&:+); end
end
