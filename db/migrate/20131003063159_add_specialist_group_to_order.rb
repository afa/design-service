class AddSpecialistGroupToOrder < ActiveRecord::Migration
  def change
   change_table :orders do |t|
    t.references :specialist_group
   end
  end
end
