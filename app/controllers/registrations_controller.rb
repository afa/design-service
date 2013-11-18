class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
   if params[:merge_order_to_user]
    @mergeable_order = PlanDevelopment.where(:id => params[:merge_order_to_user]).first.try(:order)
    if User.current.client?
     User.current.merge_order(@mergeable_order)
    end
   end
   super
   if resource.valid?
    render :json => {stage2: render_to_string(:partial => 'layouts/unregistered/registration_form2.html.haml', :locals => {:mail => resource.email})}
   else
    @alerts = []
    resource.errors.messages.each do |k, v|
     @alerts << [I18n.t(:"simple_form.labels.user.#{k}"), v.join(';')].join(' ')
    end
    flash[:alert] = "<div>#{@alerts.join("</div><div>")}</div>".html_safe
   end
   if @mergeable_order && User.current.client?
    User.current.merge_order(@mergeable_order)
   end
   Registration.registered(resource).deliver if resource.valid?
  end

  def short
   User.current.role = 'client'
   User.current.email = params[:user][:email]
   User.current.phone = params[:user][:phone]
   User.current.save
   Registration.fast_registered(User.current).deliver
   redirect_to :back
  end

  def stage2
   redirect_to root_path
  end
end
