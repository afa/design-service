# coding: utf-8
class QuestionnaireFieldCell < Cell::Rails

  def name_and_value(args)
  	@data = args[:data]
  	@details = args[:details]

    render
  end

  # нозвание поля, его значение обязательное
  def name_and_value_admin(args)
  	@data = args[:data]
  	@details = args[:details]
  	
    render
  end

  def name_and_value_not_necessarily(args)
  	@data = args[:data]
  	@details = args[:details]

    render
  end

  # нозвание поля, его значение не обязательное
  def name_and_value_not_necessarily_admin(args)
  	@data = args[:data]
  	@details = args[:details]
  	
    render
  end

end
