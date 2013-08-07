class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  belongs_to :executor, polymorphic: true
  has_many :reviews, include: :text

  scope :by_client, ->(client_id) { where(client_id: client_id) }
  # how to make polymorphic scope
  # scope :by_executor, ->(executor) { where(executor: executor) }

=begin
 state_machine :state
=end
  # TODO: fix this stub
# remove paid? after stating
  def paid?
    id % 2 == 0
  end
  def title
    orderable.title
  end
end
