# coding: utf-8
class Questionnaire < ActiveRecord::Base
	belongs_to :specialization, class_name: 'Specialization', foreign_key: 'specialization_id'

	has_and_belongs_to_many :questionnaire_fields
end