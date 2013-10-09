class AddMoreSpecializations < ActiveRecord::Migration
  def up
    Specialization.delete_all
    SpecialistGroup.find_each do |specialist_group|
      specialization_name = specialist_group.specialization_string
      specialization = Specialization.where(name: specialization_name).first_or_create
      specialist_group.specialization = specialization
      specialist_group.save
    end
    remove_column :specialist_groups, :specialization_string
  end

  def down
    Specialization.delete_all
    add_column :specialist_groups, :specialization_string, :string
  end
end
