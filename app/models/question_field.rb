# coding: utf-8
class QuestionField < ActiveRecord::Base
	belongs_to :question, class_name: 'Question', foreign_key: 'question_id'

	has_one :attachment, as: :attachable, class_name: 'Attachment', dependent: :destroy

  has_many :worksheet_experiences

	extend Enumerize
  	enumerize :displays, in: ['photo_test', 'question_for_random_question', 'check_select', 'check_value', 'yes_no', 'description_with_file',
  		'experience_min', 'experience_max', 'value', 'check_select_no_level']

  	def get_photo
  		Attachment.where("attachable_id = ? and attachable_type = 'QuestionField'", self.id).first
  	end

  	def set_statis_is_true(statis_is_true)
  		this_count_true = self.question.question_fields.where("statis_is_true = true").count

  		if !statis_is_true || self.question.count_true.to_i > this_count_true.to_i
  			if update_attribute(:statis_is_true, statis_is_true)
	  			"success"
	  		else
	  			"error"
	  		end
  		else
  			"no_update"
  		end
  	end
end
