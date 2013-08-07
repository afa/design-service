ActiveAdmin.register Order do
  decorate_with OrderDecorator
  controller do
    has_scope :by_client, as: :client, only: [:index]
    # polymorphic association
    # has_scope :by_executor, as: :executor, only: [:index]
    def permitted_params
      params.permit(order: [{executor_ids: []}, :completion_status, :price])
    end
  end

  show do
    render partial: 'order'
  end
  form partial: 'form'
end
