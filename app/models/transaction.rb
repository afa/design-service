class Transaction < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :source, :polymorphic => true
  belongs_to :destination, :polymorphic => true
  belongs_to :order
end
