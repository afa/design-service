class MainPortfolio < ActiveRecord::Base
  belongs_to :owner
  belongs_to :portfolio
  # attr_accessible :title, :body
end
