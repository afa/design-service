# coding: utf-8
class QuestionnaireField < ActiveRecord::Base
	has_and_belongs_to_many :questionnaires
end
