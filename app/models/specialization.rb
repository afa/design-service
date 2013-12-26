class Specialization < ActiveRecord::Base
  has_many :specialists, through: :specialist_groups
  has_many :specialist_groups
  has_many :specialists
  def to_s
    title
  end
  def full_name
    (sub_name && !sub_name.blank?) ? "#{name}_#{sub_name}" : name
  end
end
