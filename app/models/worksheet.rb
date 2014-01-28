class Worksheet < ActiveRecord::Base
	has_many :worksheet_fields

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
	end
end
