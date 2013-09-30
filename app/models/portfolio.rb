class Portfolio < ActiveRecord::Base
  belongs_to :specialist
  belongs_to :specialist_group
  has_and_belongs_to_many :portfolio_items
end
