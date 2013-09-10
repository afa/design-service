class OrderCustomizer < ActiveRecord::Base
  has_many :selected_forms
  def self.by_type(type)
    where(typename: type).limit(1).first
  end
end
