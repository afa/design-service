class Transaction < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :source
  belongs_to :destination
  belongs_to :order
end
