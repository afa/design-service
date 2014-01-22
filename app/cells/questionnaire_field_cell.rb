class QuestionnaireFieldCell < Cell::Rails

  def name_and_value(args)
  	data = args[:data]
  	@name = data.name

    render
  end

  def name_and_value_admin(args)
  	data = args[:data]
  	@name = data.name
  	
    render
  end

  def name_and_value_not_necessarily(args)
  	data = args[:data]
  	@name = data.name

    render
  end

  def name_and_value_not_necessarily_admin(args)
  	data = args[:data]
  	@name = data.name
  	
    render
  end

end
