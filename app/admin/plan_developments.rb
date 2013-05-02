ActiveAdmin.register PlanDevelopment do
  menu label: ->(){ I18n.t('plan_developments.title') }
  config.filters = false

  decorate_with PlanDevelopmentDecorator

  index do
    column :id
    default_actions
    column :client
    column :full_address
    column :num_plans
    column :price
    column :num_guests_description
    column :join_kitchen_with_living_room
    column :big_kitchen
    column :cloakroom_needed
    column :cabinet_needed
    column :num_builtin_closets
    column :num_bedrooms
    column :washing_room_needed
    column :num_standpipes

    column :attachment
    column :comment
    column :family_composition

    column :created_at
    column :updated_at
  end

  form partial: 'form'

  controller do
    def permitted_params
      params.permit(plan_development: [:price])
    end
  end
end
