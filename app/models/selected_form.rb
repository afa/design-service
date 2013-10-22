class SelectedForm < ActiveRecord::Base
  include ActsAsOrderable
  belongs_to :order_customizer
  has_many :floor_plans, :dependent => :destroy

  extend Enumerize
  enumerize :interior_style, in: [:classicism, :modern_minimalism, :east, :modernart_deco, :any]
  enumerize :show_results, in: [:'3d_visualization', :freehand_drawing]
  enumerize :show_results_different, in: [:'palette_combinations', :'3d_visualization', :freehand_drawing]

  scope :by_type, ->(type){ joins(:order_customizer).where(order_customizers: {typename: type}) }

  accepts_nested_attributes_for :floor_plans, allow_destroy: true, reject_if: :room_not_filled?

  def attachment_kinds
    ['plan_with_furniture']
  end

  def self.default_params
    {  }
  end

  def title
    I18n.t "titles.#{self.class.name.underscore}.#{order_customizer.typename}"
  end

  def typename
    order_customizer.typename
  end

  def typename=(type)
    order_customizer = OrderCustomizer.by_type(type)
  end

  def room_not_filled?(hsh)
    (hsh[:room].blank? || hsh[:room] == 'например, Кухня') &&
      [:artificial_cold, :artificial_warm, :carpet_or_printed_carpet, :stone, :tree].all?{|attr| !hsh[attr] || hsh[attr] == '0' }
  end
end
