# coding: utf-8
class QuestionField < ActiveRecord::Base
	belongs_to :question, class_name: 'Question', foreign_key: 'question_id'

	has_one :attachment, as: :attachable, class_name: 'Attachment', dependent: :destroy

	extend Enumerize
  	enumerize :displays, in: ['photo_test', 'question_for_random_question']

  	def get_photo
  		Attachment.where("attachable_id = ? and attachable_type = 'QuestionField'", self.id).first
  	end
end
