class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  has_and_belongs_to_many :executors, class_name: 'Specialist', join_table: 'order_executors'
  has_many :reviews, include: :text

  scope :by_client, ->(client_id) { where(client_id: client_id) }
  scope :by_executor, ->(executor_id) { joins(:executors).where(specialists: {id: executor_id} ) }
end
