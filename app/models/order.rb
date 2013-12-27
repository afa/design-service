# coding: utf-8
class Order < ActiveRecord::Base
  self.per_page = 20

  belongs_to :orderable, polymorphic: true
  belongs_to :client, class_name: 'User', foreign_key: 'client_id', counter_cache: true, include: :profile
  belongs_to :executor, polymorphic: true
  belongs_to :specialist_group
  has_many :reviews, dependent: :destroy
  has_many :messages, as: :attached_to, dependent: :destroy, include: :attachments
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
  scope :from_users_by_role, ->(role) { joins(:client).where(users: {role: role}) }
  scope :not_empty, ->{where("work_state != 'draft'")}

  before_save if: ->(order){ order.changed_attributes.has_key?('executor_id') ||
                            order.changed_attributes.has_key?('executor_type') } do
    assign_specialist(false)
  end
  before_save if: ->(order){ order.draft? && !(order.changed_attributes.keys - %w(created_at updated_at id)).empty?} do
   work_state = 'saved_draft'
  end

  state_machine :work_state, initial: :draft do
    state :draft
    state :saved_draft
    state :sent_to_moderator
    state :moderator_suggested
    state :specialist_agreed
    state :specialist_disagreed
    state :client_agreed
    state :in_work
    state :work_accepted

    event :save_draft do
      transition [:draft, :saved_draft] => :saved_draft
    end
    event :send_to_moderator do
      transition [:saved_draft, :sent_to_moderator, :moderator_suggested, :specialist_agreed] => :sent_to_moderator
    end
    event :save_draft_drop_price do
      transition [:draft, :saved_draft, :sent_to_moderator, :moderator_suggested, :specialist_agreed] => :saved_draft, before: :reset_price
    end

    event :assign_specialist do
      transition [:moderator_suggested, :specialist_agreed, :specialist_disagreed] => :moderator_suggested
      transition [:saved_draft, :client_agreed, :sent_to_moderator, :in_work] => same
      transition [:draft] => :saved_draft
    end

    event :set_price do
      transition [:sent_to_moderator, :moderator_suggested] => :moderator_suggested, :if => :test_price
      transition :saved_draft => :saved_draft
    end
    after_transition :sent_to_moderator => :moderator_suggested, :do => :say_to_spec

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

  def say_to_spec
   SpecialistMailer.new_order(self.executor.user, self)
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

  def money_for_specialist_calc(specialist)
    return nil  unless specialist && specialist.is_a?(Specialist)
    labor_participation = specialist.labor_participation || 1.0
    if labor_participation
      (price || default_price).to_f * labor_participation
    else
      price
    end
  end

  def reset_price
    price = nil
  end

  # дата обновления в нужном формате
  def get_updated_date
    updated_at.strftime("%d.%m.%Y")
  end

  # дата создания в нужном формате
  def get_created_date
    created_at.strftime("%d.%m.%Y")
  end

  # НУЖНО ДОРАБОТАТЬ ЗАПРОСЫ, НАПИСАНО КОРЯВО
  # берется пачка заказов, по определенному фильтру
  def get_bunch_on_filter(page, filter)
    filtres = filter.split(/_/)

    if filtres[0] == "state" # берем по статусу
      name = filter[filter.index('_') + 1, filter.length - filter.index('_')]
      Order.paginate(:page => page).where("work_state = ?", name).order("orders.updated_at desc")
    elsif filtres[0] == "type" # берем по типу
      typename = filter[filter.index('_') + 1, filter.length - filter.index('_')]
      if typename == "EngineeringSystem" || typename == "PlanDevelopment"  || typename == "ReplanningEndorsement" 
        Order.paginate(:page => page)\
          .joins("inner join selected_forms on selected_forms.id = orders.orderable_id")\
          .where("orders.orderable_type = ?", typename)\
          .order("orders.updated_at desc")
      else # SelectedForm_:id
        id = typename[typename.index('_') + 1, typename.length - typename.index('_')].to_i
        Order.paginate(:page => page)\
          .joins("inner join selected_forms on selected_forms.id = orders.orderable_id")\
          .where("orders.orderable_type = 'SelectedForm' and selected_forms.order_customizer_id = ?", id)\
          .order("orders.updated_at desc")
      end
    elsif filter == "update_date_desc"
      Order.paginate(:page => page).order("updated_at desc")
    elsif filter == "update_date_asc"
      Order.paginate(:page => page).order("updated_at asc")
    elsif filter == "client_asc"
      Order.paginate(:page => page).joins(:client)\
        .joins("inner join profiles on profiles.user_id = users.id")\
        .order("profiles.surname asc")
    elsif filter == "client_desc"
      Order.paginate(:page => page)
        .joins("left join users on orders.client_id = users.id")\
        .joins("left join profiles on profiles.user_id = users.id")\
        .order("profiles.surname desc")
    elsif filter == "price_asc"
      Order.paginate(:page => page).order("price asc")
    elsif filter == "price_desc"
      Order.paginate(:page => page).order("price desc")
    elsif filter == "specialist_asc"
      Order.paginate(:page => page)\
        .joins("left join specialists on specialists.user_id = orders.executor_id")\
        .joins("left join users on specialists.user_id = users.id")\
        .joins("left join profiles on profiles.user_id = users.id")\
        .where("orders.executor_type = 'Specialist' or orders.executor_type is null")\
        .order("profiles.surname asc")
    elsif filter == "specialist_desc"
      Order.paginate(:page => page)\
        .joins("left join specialists on specialists.user_id = orders.executor_id")\
        .joins("left join users on specialists.user_id = users.id")\
        .joins("left join profiles on profiles.user_id = users.id")\
        .where("orders.executor_type = 'Specialist' or orders.executor_type is null")\
        .order("profiles.surname desc")
    elsif filter == "create_date_desc"
      Order.paginate(:page => page).order("created_at desc")
    elsif filter == "create_date_asc"
      Order.paginate(:page => page).order("created_at asc")
    else
      Order.paginate(:page => page).order("updated_at desc")
    end
  end

  # количество заказов, по определенному фильтру
  def count_orders(filter)
    filtres = filter.split(/_/)

    if filtres[0] == "state" # берем по статусу
      name = filter[filter.index('_') + 1, filter.length - filter.index('_')]
      Order.where("work_state = ?", name).count
    else
      Order.count
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
