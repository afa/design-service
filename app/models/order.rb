class Order < ActiveRecord::Base
  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true
  belongs_to :executor, polymorphic: true
  belongs_to :specialist_group
  has_many :reviews, dependent: :destroy
  has_many :messages, as: :attached_to, dependent: :destroy
  has_many :payments
  has_many :purchases, :through => :payments
  has_many :attachments, as: :attachable
  has_many :transactions

  has_many :transactions_in, :as => :destination, :class_name => 'Transaction'
  has_many :transactions_out, :as => :source, :class_name => 'Transaction'

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
    state :specialist_disagreed
    state :client_agreed
    state :in_work
    state :work_accepted

    event :save_draft do
      transition :draft => :draft
    end
    event :set_price do
      transition [:draft, :moderator_suggested] => :moderator_suggested, :if => :test_price
      transition :draft => :draft
    end

    event :agree do
      transition :moderator_suggested => :specialist_agreed, if: :current_user_is_a_specialist?
      transition :specialist_agreed => :client_agreed, if: :current_user_is_a_client?
    end
    after_transition :specialist_agreed => :client_agreed, :do => :mk_payment

    event :start_work do
      transition [:in_work, :client_agreed] => :in_work,  :if => :must_start_work?
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

  def mk_payment
   pay = self.payments.create :amount => need_amount
   pay.request!
  end

  def test_price
   not price.blank? || executor.nil?
  end

  def can_pay?
   client_agreed? || in_work? || work_accepted? && (!paid?)
  end

  def can_agree_price?
    current_user_is_a_specialist? && moderator_suggested? || current_user_is_a_client? && specialist_agreed?
  end

  def interlocutor(user)
    if user == client
      executor
    elsif executor.is_a?(Specialist) && user == executor.user
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

  def qiwi
   transactions_in.map(&:amount).sum - transactions_out.map(&:amount).sum
  end

  def give(whom, how_many, for_order = self)
   return false if how_many > qiwi
   Transaction.create :source => self, :destination => whom, :order => for_order, :amount => how_many
  end

  # FIX ME: refactor
  def amount_paid
    payments.where(:state => :paid).inject(0.0){|r, p| r + p.amount }
    #purchases.where(:state => :paid).inject{|sum,purchase| sum + purchase.payments.where(:state => :paid).inject(0.0){|r,payment| r + payment.amount } }
  end

  def need_amount
   return 0.0 if amount_paid.to_f >= price.to_f
   return price - amount_paid.to_f #if amount_paid.to_f > advance_price.to_f
   #return advance_price.to_f - amount_paid.to_f
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

  def current_user_is_a_specialist?
    User.current.specialist? &&  User.current.specialist == executor
  end
  def current_user_is_a_client?
    User.current.client? &&  User.current == client
  end

  def price=(value)
    write_attribute(:price, value).tap do
      set_price(false)  if valid_price?
    end
  end

  def default_price
    orderable.default_price
  end

  def valid_price?
    price && price > 0.0
  end

  def money_for_specialist
    return nil  unless executor && executor.is_a?(Specialist)
    labor_participation = executor.labor_participation || 1.0
    if labor_participation
      (price || default_price).to_f * labor_participation
    else
      price
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
