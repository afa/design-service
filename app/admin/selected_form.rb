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

ActiveAdmin.register SelectedForm do
  menu label: ->(){ 'Дизайн проекты' }
  config.filters = false

  decorate_with SelectedFormDecorator

  show do
    attributes_table do
      row :title
      row :wishes
      row :interior_style do |value|
        value.interior_style.text
      end
      row :interior_style_comment

      row :show_results do |value|
        value.show_results.text
      end
      row :show_results_different
      [
      :main_color,
      :flat_area,
      :room_name
      ].each do |row_name|
        row row_name
      end
      [:decorative_plaster,
      :wallpaper,
      :ceramic_tiles,
      :tree,
      :natural_stone,
      :cold_gamma,
      :bright_saturated_colors,
      :warm_color,
      :pastel_shades].each do |row_name|
        row row_name do |value|
          true_false_nil value.send(row_name)
        end
      end
    end
  end
end
