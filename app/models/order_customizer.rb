class OrderCustomizer < ActiveRecord::Base
  scope :scope_by_type, ->(type){ where(typename: type).limit(1) }
  def self.by_type(type)
    scope_by_type(type).first
  end
end
