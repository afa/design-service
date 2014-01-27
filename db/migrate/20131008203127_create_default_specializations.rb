# coding: utf-8
class CreateDefaultSpecializations < ActiveRecord::Migration
  def up
   Specialization.where(:name => 'designer').first_or_create do |s|
    s.title = 'Дизайнеры'
   end
   Specialization.where(:name => 'architector').first_or_create do |s|
    s.title = 'Архитекторы'
   end
   Specialization.where(:name => 'building_company').first_or_create do |s|
    s.title = 'Строительные компании'
   end
   Specialization.where(:name => 'building_brigade').first_or_create do |s|
    s.title = 'Строительные бригады'
   end
   #Specialization.where(:name => 'engineer').first_or_create do |s|
   # s.title = 'Дизайнеры'
   #end
  end

  def down
   Specialization.where(:name => %w(designer architector engineer building_company building_brigade)).delete_all
  end
end
