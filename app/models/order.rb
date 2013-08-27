class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  belongs_to :executor, polymorphic: true
  has_many :reviews, dependent: :destroy
  has_many :messages, as: :attached_to, dependent: :destroy
  has_many :payments
  has_many :purchases, :through => :payments
  has_many :attachments, as: :attachable

  scope :by_client, ->(client_id) { where(client_id: client_id) }
  scope :by_executor, ->(executor) { where(executor_id: executor.id, executor_type: executor.class.name) }

  state_machine :work_state, initial: :draft do
    state :draft
    state :specialist_suggested
    state :client_agreed
    state :in_work
    state :work_accepted

    event :save_draft do
      transition :draft => :draft
    end
    event :set_price do
      transition :draft => :specialist_suggested
    end
    event :agree do
      transition :specialist_suggested => :client_agreed
    end

    event :start_work do
      transition [:in_work, :agree] => :in_work,  :if => :must_start_work?
    end

    event :accept_work do
      transition :in_work => :work_accepted
    end
  end

  state_machine :payment_state, initial: :not_paid do
    state :not_paid
    state :advance_paid
    state :paid

    state :not_paid do
      def must_start_work?; false; end
    end
    state :advance_paid, :paid do
      def must_start_work?; true; end
    end

    event :pay do
      transition [:not_paid, :advance_paid] => :paid, :if => lambda {|order| order.amount_paid >= order.price }
      transition [:not_paid, :advance_paid] => :advance_paid, :if => lambda {|order| order.amount_paid >= order.advance_price }
      transition [:not_paid, :paid] => same
    end
  end

  def interlocutor(user)
    if user == client
      executor
    elsif user == executor
      client
    else
      raise "This user doesn't have access to this dialog"
    end
  end

  def authorized_user?(user)
    user && (user == client || user == executor || user.moderator?)
  end

  def title
    orderable.title
  end

  #def num_of_unfinished_works
  #  orderable.num_plans.to_i - attachments.size
  #end
  def unfinished_attachments
    orderable.attachment_kinds - attachments.pluck(:kind)
  end
end
