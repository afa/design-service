class Worksheet < ActiveRecord::Base
	has_many :worksheet_fields

	# возможно нужно будет переделать с учетом переделываний формы для вьюхи
	def add(params)
		save

		params[:questionnaire_field].each do |value|
			data = value.last
			data = "country-#{value.last}" unless value.first.at("country").nil?
			data = "region-#{value.last}" unless value.first.at("region").nil?
			data = "city-#{value.last}" unless value.first.at("city").nil?
			
			self.worksheet_fields << WorksheetField.create(:value => data, :questionnaire_fields_questionnaire_id => value.first[ value.first.index('-') + 1 , value.first.length - value.first.index('-') - 1 ].to_i)
			self.save
		end

		params[:question_field].each do |value|
			index_id = value.last[ value.last.index('-') + 1 , value.last.length - value.last.index('-') - 1 ].to_i

			if !value.first.at("description_work").nil?
				value_data = value.last
				attach = 
			elsif !value.first.at("value").nil?
				value_data = value.last
				question_field_id = nil
				question_id = index_id
			else
				question_id = nil
				value_data = value.last
				question_field_id = index_id
			end

			self.worksheet_question_fields << WorksheetQuestionField.create(:question_field_id => question_field_id,
				:value => value_data, :question_id => question_id)
			self.save
		end
	end
end
