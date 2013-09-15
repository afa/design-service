class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  belongs_to :executor, polymorphic: true
  has_many :reviews, dependent: :destroy
  has_many :messages, as: :attached_to, dependent: :destroy
  has_many :payments
  has_many :purchases, :through => :payments
  has_many :attachments, as: :attachable
  has_many :transactions

  scope :by_client, ->(client_id) { where(client_id: client_id) }
  scope :by_executor, ->(executor) { where(executor_id: executor.id, executor_type: executor.class.name) }
  scope :accepted_to_start_work, ->{ where(accepted_to_start_work_arel) }
  scope :at_least_advance_paid, -> { where(at_least_advance_paid_arel) }
  scope :in_work, -> { where(in_work_arel) }
  scope :not_in_work, -> { where(in_work_arel.not) }

  state_machine :work_state, initial: :draft do
    state :draft
    state :moderator_suggested
    state :specialist_agreed
    state :client_agreed
    state :in_work
    state :work_accepted

    event :save_draft do
      transition :draft => :draft
    end
    event :set_price do
      transition [:draft, :moderator_suggested] => :moderator_suggested
    end

    event :agree do
      transition :moderator_suggested => :specialist_agreed, if: ->{ User.current.specialist? }
      transition :specialist_agreed => :client_agreed, if: ->{ User.current.client? }
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

  def to_s
    title
  end

  def unfinished_attachments
    orderable.attachment_kinds - attachments.pluck(:kind)
  end

  def advance_price
    price && price * 0.5
  end

  # FIX ME: refactor
  def amount_paid
    purchases.where(state: paid).inject{|sum,purchase| sum + purchase.payments.where(state: paid).inject(0.0){|r,payment| r + payment.amount } }
  end

  def possible_executors
    if executor.is_a?(Specialist)
      [executor]
    elsif executor.is_a?(SpecialistGroup)
      executor.specialists
    elsif !executor
      Specialist.all
     end
  end
private
  def self.accepted_to_start_work_arel
    arel_table[:work_state].eq_any([:client_agreed, :in_work, :work_accepted])
  end
  def self.at_least_advance_paid_arel
    arel_table[:payment_state].eq_any([:paid, :advance_paid])
  end
  def self.in_work_arel
    at_least_advance_paid_arel.or(accepted_to_start_work_arel)
  end
end
