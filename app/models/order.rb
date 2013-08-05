class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  has_many :order_parts
  has_many :executors, through: :order_parts
  has_many :reviews, include: :text

  scope :by_client, ->(client_id) { where(client_id: client_id) }
  scope :by_executor, ->(executor_id) { joins(:executors).where(specialists: {id: executor_id} ) }

  # TODO: fix this stub
  def paid?
    id % 2 == 0
  end
  def title
    orderable.title
  end
  def executors
    order_parts.map(&:executor)
  end
end
