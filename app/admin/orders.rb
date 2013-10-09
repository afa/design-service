ActiveAdmin.register Order do
  menu label: ->(){ I18n.t('titles.orders') }
  decorate_with OrderDecorator
  controller do
    respond_to :json
    has_scope :by_client, as: :client, only: [:index]
    has_scope :from_users_by_role, default: 'client', only: [:index]
    # polymorphic association
    # has_scope :by_executor, as: :executor, only: [:index]
    def permitted_params
      params.permit(order: [:executor_id, :price, :specialist_price])
    end
    def update
      resource.assign_attributes(permitted_params[:order])
      resource.executor_type = 'Specialist'
      resource.save
      redirect_to action: 'show'
    end
  end

  table_columns = lambda do |table|
    table.instance_eval do
      # default_actions
      column 'Дата обновления', :updated_at
      column 'Действия', class: 'moderator_action' do |order|
        link_to order.admin_actions, admin_order_path(order)
      end
      column 'Статус', sortable: :work_state do |order|
        order.admin_work_state
      end
      column 'Заказчик', :client
      # Здесь хорошо бы ещё сортировать по подтипу, но не факт, что это возможно
      column 'Тип заказа', sortable: :orderable_type, class: 'order_type' do |order|
        link_to order.title, [:admin, order.orderable], class: order.orderable.source.class.name
      end
      column 'Цена', :price
      column 'Исполнитель', :executor
      column "Цена для специалиста", :specialist_price
      column 'Номер заказа', :id
      column 'Дата создания', :created_at
    end
  end

  show do
    table_for [resource] do
      table_columns.call(self)
    end
    render partial: 'order', locals: {order: resource}
  end


  index do
    div link_to('Заказы от зарегистрированных пользователей', admin_orders_path(from_users_by_role: 'client'))
    div link_to('Заказы от гостей', admin_orders_path(from_users_by_role: 'guest'))
    table_columns.call(self)
  end

end
