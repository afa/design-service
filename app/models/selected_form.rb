class SelectedForm < ActiveRecord::Base
  include ActsAsOrderable
  belongs_to :order_customizer
  has_many :floor_plans

  extend Enumerize
  enumerize :interior_style, in: [:classicism, :modern_minimalism, :east, :modernart_deco, :any]
  enumerize :show_results, in: [:'3d_visualization', :freehand_drawing]
  enumerize :show_results_different, in: [:'palette_combinations', :'3d_visualization', :freehand_drawing]

  scope :by_type, ->(type){ joins(:order_customizer).where(order_customizers: {typename: type}) }

  accepts_nested_attributes_for :floor_plans

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

  def flat_area
    room_space
  end
end
