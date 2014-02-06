# coding: utf-8
class RequestSpecialist < ActiveRecord::Base
	belongs_to :specialist_group
	belongs_to :join_specialist, :class_name => 'Specialist'
	belongs_to :specialist

	# создается новая заявка на вступление в группу
	def add
		group = SpecialistGroup.find(specialist_group_id)
		group.specialists.each do |value|
			RequestSpecialist.create(:specialist_group_id => specialist_group_id,
				:specialist_id => value.id, :join_specialist_id => join_specialist_id)
		end
	end

	def get_specialists
		RequestSpecialist.where("specialist_group_id = ? and join_specialist_id = ?", specialist_group_id, join_specialist_id)
	end

	def get_percent_true
		count_true = 0

		self.get_specialists.each do |value|
			if value.status
				count_true += 1
			else
				count_true += 1 if value.created_at < 3.day.ago
			end
		end

		count_true * 100 / self.get_specialists.count
	end
end
