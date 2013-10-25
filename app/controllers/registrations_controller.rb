class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
   super
   unless resource.valid?
    @alerts = []
    resource.errors.messages.each do |k, v|
     @alerts << [I18n.t(:"simple_form.labels.user.#{k}"), v.join(';')].join(' ')
    end
    flash[:alert] = "<div>#{@alerts.join("</div><div>")}</div>".html_safe
   end
  end
end
