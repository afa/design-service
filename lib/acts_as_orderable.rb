module ActsAsOrderable
  def price; order.price; end
  def price=(value); order.price = value; end
  def paid?; order.paid?; end
  def title; I18n.t "titles.#{self.class.name.underscore}"; end
  module ClassMethods
    def make_order(params, user)
      new(params) do |o|
        o.build_order{|order| order.client = user }
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      has_one :order, as: :orderable
      has_one :client, through: :order
      has_paper_trail
      # scopes use select not to be readonly
      # .readonly(false) can be used instead
      # In rails 4 this problem is fixed
      scope :by_client, ->(client_id) { joins(:order).where(orders: {client_id: client_id} ) }
    end
  end
end
