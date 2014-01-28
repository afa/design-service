class WorksheetField < ActiveRecord::Base
	belongs_to :questionnaire_fields_questionnaire, class_name: 'QuestionnaireFieldsQuestionnaire', foreign_key: 'questionnaire_fields_questionnaire_id'
	belongs_to :worksheet, class_name: 'Worksheet', foreign_key: 'worksheet_id'

	def add_avatar(user_avatar)
		save
		user_guest = User.new_guest

		attachment = Attachment.new
		attachment.file = user_avatar
		attachment.attachable = self
		attachment.user = user_guest
		attachment.save

		# режется фотка
		#set(attachment.file.current_path, 152, 152)

		{ :status => "user_avatar", :worksheet_field_id => self.id, :photo => attachment.file.url + "?#{SecureRandom.hex}" }
	end

	# ДАННЫЙ МЕТОД ДОЛЖЕН ХРАНИТЬСЯ В АДЕКВАТНОМ КЛАССЕ, А НЕ ТУТ
	# сначала изменяется размер с сохранением пропорций, затем обрезается лишнее(снизу или справа) до нужного размера
    def set(image_path, width_in_px, height_in_px)
		require 'RMagick'
        image = Magick::Image::read(image_path).first

        # возвращает в байтах
        if image.filesize < 10*1024*1024 #10 мегабайт
            width = image.columns.to_f
            height = image.rows.to_f

            del = width_in_px.to_f / height_in_px.to_f
            del1 = height_in_px.to_f / width_in_px.to_f
            del_this = width / height

            # форматируем до нужных пропорций  

            if del_this < del # ширина больше чем надо
              a = height / width * del * 100
              height = 100 * height / a
            else # высота больше чем надо
              a = width / height * del1 * 100
              width = 100 * width / a
            end

            image =  image.crop(0, 0, width, height)
            #image =  image.crop(0, 0, width_in_px, height_in_px)

            #if width > width_in_px && height > height_in_px
                image.resize_to_fit!(width_in_px, height_in_px)
                #image.resize_to_fit!(width, height)
            #end

            image.write(image_path)
            "success"
        else
            File.delete(image_path)
            "error"
        end
    end
end
