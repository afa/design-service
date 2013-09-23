class AddNewColumsToSelectedForms < ActiveRecord::Migration
  def change
    add_column :selected_forms, :decorative_plaster, :boolean
    add_column :selected_forms, :wallpaper, :boolean
    add_column :selected_forms, :ceramic_tiles, :boolean
    add_column :selected_forms, :tree, :boolean
    add_column :selected_forms, :natural_stone, :boolean
    add_column :selected_forms, :cold_gamma, :boolean
    add_column :selected_forms, :bright_saturated_colors, :boolean
    add_column :selected_forms, :warm_color, :boolean
    add_column :selected_forms, :pastel_shades, :boolean
    add_column :selected_forms, :main_color, :string
  end
end
