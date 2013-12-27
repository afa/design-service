# coding: utf-8
class AddPicturesOfDesignProjects < ActiveRecord::Migration
  def up
    OrderCustomizer.where(typename: 'accesories').first_or_create(name: 'Аксессуары')
    OrderCustomizer.find_each do |order_customizer|
      order_customizer.image = "design_projects/#{order_customizer.typename}.jpg"
      order_customizer.save
    end
  end

  def down
  end
end
