class WorksheetExperience < ActiveRecord::Base
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'
	belongs_to :question_field, class_name: 'QuestionField', foreign_key: 'question_field_id'

	def get_status_necessarily(value, params)
		status = "success"
		is_field = false
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first
		fields = field_name.split('_')
		field_data = nil

		begin
        	field_data = Question.find(index_id)
        rescue
            status = "error_field"
        end

        unless field_data.nil?
			responsibility = params[:question_field]["experience_description_#{fields.last}_1-#{index_id}"] +\
				params[:question_field]["experience_description_#{fields.last}_2-#{index_id}"] +\
				params[:question_field]["experience_description_#{fields.last}_3-#{index_id}"]

			if responsibility == "" || responsibility.nil?
				status = "nil_experience_description"
			end

			date_start = params[:question_field]["experience_date_start_#{fields.last}-#{index_id}"]
			if date_start.nil? || date_start == ""
				status = "nil_experience_date_start"
			end

			date_end = params[:question_field]["experience_date_end_#{fields.last}-#{index_id}"]
			if date_end.nil? || date_end == ""
				status = "nil_experience_date_end"
			end

			city = params[:question_field]["experience_city_#{fields.last}-#{index_id}"]
			if city.nil? || city == ""
				status = "nil_experience_city"
			end

			country = params[:question_field]["experience_country_#{fields.last}-#{index_id}"]
			if country.nil? || country == ""
				status = "nil_experience_country"
			end

			region = params[:question_field]["experience_region_#{fields.last}-#{index_id}"]
			if region.nil? || region == ""
				status = "nil_experience_region"
			end
		end

		status
	end

	def get_new(value, params)
		field = value.first.split('-')
		index_id = field.last.to_i
		field_name = field.first
		fields = field_name.split('_')

		responsibility = params[:question_field]["experience_description_#{fields.last}_1-#{index_id}"] +\
			params[:question_field]["experience_description_#{fields.last}_2-#{index_id}"] +\
			params[:question_field]["experience_description_#{fields.last}_3-#{index_id}"]

		unless params[:question_field]["experience_date_start_#{fields.last}-#{index_id}"].nil?
			date_start = params[:question_field]["experience_date_start_#{fields.last}-#{index_id}"]
			begin
				date_start = DateTime.parse(date_start)
			rescue
			end
		else
			date_start = nil
		end

		unless params[:question_field]["experience_date_end_#{fields.last}-#{index_id}"].nil?
			date_end = params[:question_field]["experience_date_end_#{fields.last}-#{index_id}"]
			begin
				date_end = DateTime.parse(date_end)
			rescue
			end
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
		
		WorksheetExperience.new(
			:name => params[:question_field]["experience_name_#{fields.last}-#{index_id}"],
			:position => params[:question_field]["experience_position_#{fields.last}-#{index_id}"],
			:responsibility => responsibility, 
			:date_start => date_start, 
			:date_last => date_end,
			:question_field_id => index_id,
			:sity => sity, 
			:country => country, 
			:region => region
		)
	end
end