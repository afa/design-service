class SpecialistGroup < ActiveRecord::Base
  include Likeable
  has_many :specialists
  has_many :portfolio_items, through: :specialists, include: :photo_collection
  def messages; specialists.map(&:messages).inject(&:+); end

  def positive_feedback; specialists.map(&:positive_feedback).inject(0,&:+); end
  def negative_feedback; specialists.map(&:negative_feedback).inject(0,&:+); end
  def number_of_completed_orders; specialists.map(&:number_of_completed_orders).inject(0,&:+); end
end
