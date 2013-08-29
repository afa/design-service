ActiveAdmin.register Order do
  decorate_with OrderDecorator
  controller do
    respond_to :json
    has_scope :by_client, as: :client, only: [:index]
    # polymorphic association
    # has_scope :by_executor, as: :executor, only: [:index]
    def permitted_params
      params.permit(order: [:executor_id, :price])
    end
    def update
      resource.assign_attributes(permitted_params[:order])
      resource.executor_type = 'Specialist'
      resource.save
      redirect_to action: 'show'
    end
  end

  show do
    render partial: 'order', locals: {order: resource}
  end
  form partial: 'form'
end
