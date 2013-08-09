class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  belongs_to :executor, polymorphic: true
  has_many :reviews
  has_many :messages, as: :attached_to

  scope :by_client, ->(client_id) { where(client_id: client_id) }
  scope :by_executor, ->(executor) { where(executor_id: executor.id, executor_type: executor.class.name) }

  def interlocutor(user)
    if user == client
      executor
    elsif user == executor
      client
    else
      raise "This user doesn't have access to this dialog"
    end
  end

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
