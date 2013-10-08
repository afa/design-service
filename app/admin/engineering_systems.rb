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

ActiveAdmin.register EngineeringSystem do
  menu label: ->(){ I18n.t('titles.engineering_system') }
  config.filters = false

  decorate_with EngineeringSystemDecorator

  show do
    attributes_table do
     [:full_address,
      :electrical_equipment,
      :water_supply_and_sewerage,
      :heating, :ventilation,
      :low_voltage_systems,
      :constructive_solutions].each do |row_name| 
        row row_name do |value|
          true_false_nil value.send(row_name)
        end
      end
      row :wishes
    end
  end

  controller do
    def permitted_params
      params.permit(engineering_system: [:price])
    end
  end
end
