class SelectedForm < ActiveRecord::Base
  include ActsAsOrderable
  # this model presents params for design_projects
  # attr_accessible :title, :body
  belongs_to :order_customizer

  extend Enumerize
  enumerize :interior_style, in: [:classicism, :modern_minimalism, :east, :modernart_deco, :any]
  enumerize :show_results, in: [:'3d_visualization', :freehand_drawing]

  scope :by_type, ->(type){ joins(:order_customizer).where(order_customizers: {typename: type}) }

  def attachment_kinds
    ['plan_of_flat']
  end

  def self.default_params
    {  }
  end

end
