# coding: utf-8
class QuestionField < ActiveRecord::Base
	belongs_to :question, class_name: 'Question', foreign_key: 'question_id'

	extend Enumerize
  	enumerize :displays, in: ['photo_test']
end
