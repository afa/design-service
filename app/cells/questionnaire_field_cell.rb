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

end
