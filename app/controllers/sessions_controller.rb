class SessionsController < Devise::SessionsController
  respond_to :json
  #def new
  #end

  def create
    if params[:merge_order_to_user] && !params[:merge_order_to_user].blank?
      p "---preorder", User.current.orders.where(orderable_type: 'PlanDevelopment').order("id desc").first
      @mergeable_order = PlanDevelopment.where(:id => params[:merge_order_to_user]).all.first.try(:order)
    end
    super
    if @mergeable_order && User.current.client?
      User.current.merge_order(@mergeable_order)
    end
  end

  #def destroy
  #end
end
