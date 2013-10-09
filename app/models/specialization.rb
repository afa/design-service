class Specialization < ActiveRecord::Base
 has_many :specialists
 has_many :specialist_groups
end
