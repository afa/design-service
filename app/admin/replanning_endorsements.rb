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

ActiveAdmin.register ReplanningEndorsement do
  menu label: ->(){ I18n.t('titles.replanning_endorsement') }
  config.filters = false

  decorate_with ReplanningEndorsementDecorator

  show do
    attributes_table do
      row :id
      row :order
      row :flat_area
      row :developed_by_general_projector do |value|
        true_false_nil value.developed_by_general_projector
      end
      row :replanning_organization_licensed do |value|
        true_false_nil value.replanning_organization_licensed
      end
    end
  end

  form partial: 'form'

  controller do
    def permitted_params
      params.permit(replanning_endorsement: [:price])
    end
  end
end
