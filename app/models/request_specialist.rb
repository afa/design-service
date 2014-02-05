# coding: utf-8
class RequestSpecialist < ActiveRecord::Base
	belongs_to :specialist_group
	belongs_to :join_specialist, :class_name => 'Specialist'
	belongs_to :specialist
end
