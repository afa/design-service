class OrderCustomizer < ActiveRecord::Base
  has_many :selected_forms
  def self.by_type(type)
    where(typename: type).limit(1).first
  end
  def self.by_specialization(specialization)
    where(typename: "#{specialization}_specialist").limit(1).first
  end

  # берем все типы в виде массива, возможно надо доработать
  def self.get_all
  	types = Array.new

  	types << { :typename => "EngineeringSystem".underscore, :class => 'EngineeringSystem' }
  	types << { :typename => "PlanDevelopment".underscore, :class => 'PlanDevelopment' }
  	types << { :typename => "ReplanningEndorsement".underscore, :class => 'ReplanningEndorsement' }

  	OrderCustomizer.all.each do |value|
  		types << { :id => value.id.to_s, :typename => value.typename.underscore, :class => 'SelectedForm' }
  	end

  	types
  end
end
