def true_false_nil(value)
  if value.nil?
    'Не определено'
  elsif value == false
    'Нет'
  elsif value == true
    'Да'
  else
    value
  end    
end
ActiveAdmin.register PlanDevelopment do
  menu label: ->(){ I18n.t('titles.plan_development') }
  config.filters = false

  decorate_with PlanDevelopmentDecorator

  show do
    attributes_table do
      row :id
      row :order
      row :full_address
      row :flat_area
      row :comment
      row :num_plans
      row :num_standpipes
        row :family_composition
      row :num_guests do |value|
        value.num_guests.text
      end
      row :num_rooms
      row :num_bedrooms
      row :num_builtin_closets
      row :washing_room_needed do |value|
        true_false_nil value.washing_room_needed
      end
      row :cabinet_needed do |value|
        true_false_nil value.cabinet_needed
      end
      row :cloakroom_needed do |value|
        true_false_nil value.cloakroom_needed
      end
      row :join_kitchen_with_living_room do |value|
        true_false_nil value.join_kitchen_with_living_room
      end
      row :big_kitchen do |value|
        value.big_kitchen.text
      end
    end
  end

  controller do
    def permitted_params
      params.permit(plan_development: [:price])
    end
  end
end
