class SessionsController < Devise::SessionsController
  respond_to :json
  #def new
  #end

  def create
   if params[:merge_order_to_user]
    p "---preorder", User.current.orders.where(orderable_type: 'PlanDevelopment').order("id desc").first
    @mergeable_order = PlanDevelopment.where(:id => params[:merge_order_to_user]).all.first.try(:order)
    p "---mergeorder", @mergeable_order, User.current, User.current.client?
    #if User.current.client?
    # User.current.merge_order(@mergeable_order)
    # p "---mergeorders", User.current.orders
    #end
   end
   super
   p "---spostmerge"
   p "---puser", User.current, @mergeable_order
   if @mergeable_order && User.current.client?
    User.current.merge_order(@mergeable_order)
    p "---pmod", User.current.orders
   end
  end

  #def destroy
  #end
end
