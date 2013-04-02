module SpecialistsHelper
  def subtitle
    I18n.t "#{controller_name.underscore}.#{params[:type]}.title", default: I18n.t("#{controller_name.underscore}.title")
  end 

end
