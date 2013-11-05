module ActsAsOrderable
  def price; order.price; end
  def price?; order.price?; end
  def price=(value); order.price = value; end
  def paid?; order.paid?; end
  def title; I18n.t "titles.#{self.class.name.underscore}"; end
  def authorized_user?(user)
    user && (user == order.client || user == order.executor.user || user.moderator?)
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
      orderable.save
      orderable
    end

    def default_params
      raise NotImplementedError, "Specify #{self.name}.default_params class-method with default order parameters"
    end

    def find_draft(scope = where({}))
      scope.by_client(User.current).by_work_state(['draft', 'saved_draft']).order('updated_at desc').first
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

      after_commit :on => :update do 
        if changed?
          order.save_draft_drop_price
        else
          order.save_draft
        end
        order.touch
      end

      has_paper_trail
    end
  end

  def default_price_per_square_meter
    return nil  unless flat_area
    points = [[10, 500],[30,200],[100,100],[250,60]].sort_by{|area,price| area}
    mult = {1 => 1.0, 2 => 1.9, 3 => 2.7, 4 => 3.5}[num_plans]
    if flat_area < points.first.first
      points.first.last*mult
    elsif points.last.first < flat_area
      points.last.last*mult
    else
      (area_1,price_1),(area_2,price_2) = points.each_cons(2).detect{|(area_1,price_1),(area_2,price_2)| (area_1...area_2).include?(flat_area) }
      (price_1 + (price_2 - price_1) * (flat_area - area_1)) * mult / (area_2-area_1).to_f
    end
  end
  def default_price
    return nil  unless flat_area
    default_price_per_square_meter * flat_area
  end
end
