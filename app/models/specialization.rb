class Specialization < ActiveRecord::Base
 has_many :specialists, through: :specialist_groups
 has_many :specialist_groups
end
