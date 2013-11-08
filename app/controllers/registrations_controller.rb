class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
   p "---prereguser", User.current
   if params[:merge_order_to_user]
    p "---preregorder", User.current.orders.where(orderable_type: 'PlanDevelopment').order("id desc").first
    @mergeable_order = PlanDevelopment.find(params[:merge_order_to_user]).try(:order)
    p "---mergeorder", @mergeable_order, User.current, User.current.client?
    if User.current.client?
     User.current.merge_order(@mergeable_order)
     p "---mergeorders", User.current.orders
    end
   end
   super
   unless resource.valid?
    @alerts = []
    resource.errors.messages.each do |k, v|
     @alerts << [I18n.t(:"simple_form.labels.user.#{k}"), v.join(';')].join(' ')
    end
    flash[:alert] = "<div>#{@alerts.join("</div><div>")}</div>".html_safe
   end
   p "---postmerge"
   if @mergeable_order && User.current.client?
    User.current.merge_order(@mergeable_order)
   end
   Registration.registered(resource).deliver if resource.valid?
  end
end
