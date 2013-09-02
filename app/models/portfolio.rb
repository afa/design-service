class Portfolio < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_many :portfolio_items
end
