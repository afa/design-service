ActiveAdmin.register SpecialistGroup do
  menu label: ->(){ I18n.t('titles.specialist_groups') }
  # decorate_with SpecialistGroupDecorator
  controller do
    custom_actions resource: [:remove_specialist]
    def remove_specialist
      resource.specialists.delete(Specialist.find(params[:specialist_id]))
      redirect_to [:admin, resource]
    end
    def permitted_params
      params.permit(specialist_group: {portfolio_ids: [], specialist_ids: []})
    end
    private :permitted_params
  end

  table_columns = lambda do |table|
    table.instance_eval do
      column :id
      column 'Название группы', :name, sortable: :name do |specialist_group|
        link_to specialist_group.name, admin_specialist_group_path(specialist_group)
      end
      column 'Специальность', :specialization, sortable: :specialization do |specialist_group|
        specialist_group.specialization
      end
      column 'Количество специалистов', :number_of_participants, sortable: false
      column 'Рейтинг', :rating, sortable: false
      column 'Коэффициент участия', :labor_participation
    end
  end
  index do
   table_columns.call(self)
  end
  show do
    table_for [resource] do
      table_columns.call(self)
    end
    table_for resource.specialists do
      column 'ФИО', :full_name do |specialist|
        link_to specialist.full_name, [:admin, specialist]
      end
      column 'Логин', :username, sortable: :username
      column 'Количество выполненных заказов', :number_of_completed_orders
      column 'Удалить специалиста' do |specialist|
       link_to 'Удалить из группы', admin_specialist_group_remove_specialist_path(resource, specialist_id: specialist), method: :delete
      end
    end
    table_for resource.orders do
      column :id
      column 'Тип заказа', :title, sortable: :orderable_type
      column 'Статус заказа', :work_state, sortable: :work_state
      column 'Процент выполнения', :completion_percent, sortable: :completion_percent
      column 'Заказчик', :client, sortable: :client_id do |order|
        order.client.full_name
      end
    end
    table_for resource.reviews do
      #default_actions
      column 'Заказчик', :user, sortable: :client_id do |review|
        link_to review.user.full_name, admin_user_path(review.user)
      end
      column 'Текст отзыва', :text do |review|
        link_to review.text, admin_review_path(review)
      end
      column 'К заказу', :order do |review|
        link_to review.order.title, admin_order_path(review.order)
      end
    end
  end
end
