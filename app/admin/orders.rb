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

  index do |f|
 #   default_actions
    column 'Дата обновления', :updated_at
    column 'Действия' do |order|
      link_to order.admin_actions, admin_order_path(order)
    end
    column 'Статус', sortable: :work_state do |order|
      order.admin_work_state
    end
    column :client
    # Здесь хорошо бы ещё сортировать по подтипу, но не факт, что это возможно
    column 'Тип заказа', sortable: :orderable_type do |order|
      link_to order.title, [:admin, order.orderable]
    end
    column :price
    column :executor
    column 'Номер заказа', :id
    column 'Дата создания', :created_at
  end
end
