module ActsAsOrderable
  def price; order.price; end
  def price=(value); order.price = value; end
  def paid?; order.paid?; end
  def title; I18n.t "titles.#{self.class.name.underscore}"; end
  def authorized_user?(user)
    user && (user == order.client || user == order.executor || user.moderator?)
  end

  module ClassMethods
    def make_order(params, user)
      new(params) do |o|
        o.build_order{|order| order.client = user }
      end
    end

    # creates stubby saved order with associated model and linked client
    # given block is called after save so it's a good place to build some associations
    def generate_order
      
      orderable = new(default_params) do |o|
        o.build_order(client: User.current)
      end
      yield orderable  if block_given?
      puts "\n=====================\n#{orderable.order_customizer}\n===================\n"
      orderable.save
      orderable
    end

    def default_params
      raise NotImplementedError, "Specify #{self.name}.default_params class-method with default order parameters"
    end

    def find_draft(scope = where({}))
      scope.by_client(User.current).by_work_state('draft').first
    end
    
    # block is run only for created object
    def find_or_create_order(scope = where({}), &block)
      find_draft(scope) || generate_order(&block)
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      has_one :order, as: :orderable, dependent: :destroy
      has_one :client, through: :order
      has_many :attachments, as: :attachable, class_name: 'Attachment', dependent: :destroy

      scope :by_client, ->(user){ joins(:order).where(orders: {client_id: user}) }
      scope :by_work_state, ->(state){ joins(:order).where(orders: {work_state: state}) }

      has_paper_trail
    end
  end
end
