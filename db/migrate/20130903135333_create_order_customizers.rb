class CreateOrderCustomizers < ActiveRecord::Migration
  def change
    create_table :order_customizers do |t|
      t.string :name
      t.string :image
      t.string :form_path

      t.timestamps
    end
  end
end
