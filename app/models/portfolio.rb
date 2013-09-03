class Portfolio < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_and_belongs_to_many :portfolio_items
end
