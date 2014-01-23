# coding: utf-8
class QuestionnaireFieldCell < Cell::Rails

  # нозвание поля, его значение
  def name_and_value(args)
  	@data = args[:data]
  	@details = args[:details]

    render
  end

  # нозвание поля, его значение для админки
  def name_and_value_admin(args)
  	@data = args[:data]
  	@details = args[:details]
  	
    render
  end

  # нозвание поля, дата
  def name_and_date(args)
    @data = args[:data]
    @details = args[:details]

    render
  end

  # нозвание поля, дата для админки
  def name_and_date_admin(args)
    @data = args[:data]
    @details = args[:details]
    
    render
  end

  # проживание: страна, город, регион
  def residence(args)
    @data = args[:data]
    @details = args[:details]

    render
  end

  # проживание: страна, город, регион для админки
  def residence_admin(args)
    @data = args[:data]
    @details = args[:details]
    
    render
  end

  # загружаемая фотография
  def user_photo(args)
    @data = args[:data]
    @details = args[:details]

    render
  end

  # загружаемая фотография для админки
  def user_photo_admin(args)
    @data = args[:data]
    @details = args[:details]
    
    render
  end

  # нозвание поля, его значение на всю длину
  def name_and_value_full(args)
    @data = args[:data]
    @details = args[:details]

    render
  end

  # нозвание поля, его значение на всю длину для админки
  def name_and_value_full_admin(args)
    @data = args[:data]
    @details = args[:details]
    
    render
  end

  # нозвание поля, textarea на всю длину
  def name_and_textarea_full(args)
    @data = args[:data]
    @details = args[:details]

    render
  end

  # нозвание поля, textarea на всю длину для админки
  def name_and_textarea_full_admin(args)
    @data = args[:data]
    @details = args[:details]
    
    render
  end

  # блок образования
  def education(args)
    @data = args[:data]
    @details = args[:details]

    render
  end

  # блок образования для админки
  def education_admin(args)
    @data = args[:data]
    @details = args[:details]
    
    render
  end

end
