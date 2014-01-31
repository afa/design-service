class Worksheet < ActiveRecord::Base
	has_many :worksheet_fields
	has_many :worksheet_experiences
	has_many :worksheet_educations
	has_many :worksheet_question_fields

	# возможно нужно будет переделать с учетом переделываний формы для вьюхи
	def add(params)
		save
		status = "success"

		#p "--------------------------------------------"
		#p params.inspect
		#p "--------------------------------------------"

		unless params[:questionnaire_field].nil?
			params[:questionnaire_field].each do |value|
				data = value.last
				data = "country-#{value.last}" unless value.first.at("country").nil?
				data = "region-#{value.last}" unless value.first.at("region").nil?
				data = "city-#{value.last}" unless value.first.at("city").nil?
				
				self.worksheet_fields << WorksheetField.new(:value => data, :questionnaire_fields_questionnaire_id => value.first[ value.first.index('-') + 1 , value.first.length - value.first.index('-') - 1 ].to_i)
				self.save
			end
		end

		unless params[:worksheet_education].nil?
			params[:worksheet_education].each do |value|
				field = value.first.split('-')
				index_id = field.last.to_i
				field_name = field.first

				if !field_name.at("type").nil?
					fields = field_name.split('_')

					date_last = nil
					begin
						date_last = DateTime.parse(params[:worksheet_education]["date_last_#{fields.last}-#{index_id}"])
					rescue
					end

					self.worksheet_educations << WorksheetEducation.new(
						:type_education => params[:worksheet_education]["type_#{fields.last}-#{index_id}"],
						:name => params[:worksheet_education]["name_#{fields.last}-#{index_id}"],
						:date_last => date_last)
					self.save
				end
			end
		end

		unless params[:question_field].nil?
			params[:question_field].each do |value|
				is_field = true
				field = value.first.split('-')
				index_id = field.last.to_i
				field_name = field.first

				value_level = nil
				value_description = nil
				attach = nil
				is_attach = false

				#p "--------------------------------------------"
				#p value.inspect
				#p field_name.inspect
				#p "--------------------------------------------"

				if !field_name.at("experience_name").nil?
					is_field = false
					fields = field_name.split('_')
					responsibility = params[:question_field]["experience_description_#{fields.last}_1-#{index_id}"] +\
						params[:question_field]["experience_description_#{fields.last}_2-#{index_id}"] +\
						params[:question_field]["experience_description_#{fields.last}_3-#{index_id}"]

					unless params[:question_field]["experience_date_start_#{fields.last}-#{index_id}"].nil?
						date_start = params[:question_field]["experience_date_start_#{fields.last}-#{index_id}"]
					else
						date_start = nil
					end

					unless params[:question_field]["experience_date_end_#{fields.last}-#{index_id}"].nil?
						date_end = params[:question_field]["experience_date_end_#{fields.last}-#{index_id}"]
					else
						date_end = nil
					end

					unless params[:question_field]["experience_city_#{fields.last}-#{index_id}"].nil?
						sity = params[:question_field]["experience_city_#{fields.last}-#{index_id}"]
					else
						sity = nil
					end

					unless params[:question_field]["experience_country_#{fields.last}-#{index_id}"].nil?
						country = params[:question_field]["experience_country_#{fields.last}-#{index_id}"]
					else
						country = nil
					end

					unless params[:question_field]["experience_region_#{fields.last}-#{index_id}"].nil?
						region = params[:question_field]["experience_region_#{fields.last}-#{index_id}"]
					else
						region = nil
					end
					
					self.worksheet_experiences << WorksheetExperience.new(
						:name => params[:question_field]["experience_name_#{fields.last}-#{index_id}"],
						:position => params[:question_field]["experience_position_#{fields.last}-#{index_id}"],
						:responsibility => responsibility, :date_start => date_start, :date_end => date_end,
						:question_field_id => index_id,
						:sity => sity, :country => country, :region => region)
					self.save
				elsif !field_name.at("description_work").nil? # описание и файл
					value_data = value.last
					fields = field_name.split('_')

					unless fields.nil?
						attach = params[:question_field]["file_work_#{fields.last}-#{index_id}"]
						is_attach = true

						p "================="
						p "file_work_#{fields.last}-#{index_id}"
						p attach.inspect
					else
						status = "file_work_nil"
					end
				elsif !field_name.at("value").nil?
					value_data = value.last
					question_field_id = nil
					question_id = index_id
				else
					question_id = nil
					value_data = value.last
					question_field_id = index_id
				end

				if is_field
					self.worksheet_question_fields << WorksheetQuestionField.new(
						:question_field_id => question_field_id,
						:value => value_data, 
						:question_id => question_id,
						:value_level => value_level,
						:value_description => value_description)
					self.save

					if is_attach
						p "================="
						p attach.inspect

						attachment = Attachment.new
						attachment.file = attach
						attachment.attachable = WorksheetQuestionField.last
						attachment.user = User.new_guest
						attachment.save
					end
				end

				if status != "success"
					break
				end
			end
		end

		if status != "success"
			self.destroy
		end

		status
	end
end
