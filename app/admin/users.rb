ActiveAdmin.register User do
  decorate_with UserDecorator

  controller do
    has_scope :with_orders, type: :boolean, default: true, only: [:index]
    def permitted_params
      params.permit(user: [:role])
    end
  end

  index do |f|
    span do
      div link_to('Показать всех пользователей', admin_users_path(with_orders: false))
      div link_to('Показать только пользователей с заказами', admin_users_path(with_orders: true))
    end
    default_actions
    column :role
    column :username
    column :surname
    column :name
    column :middle_name
    column :email
    column :orders_info_link
    column :specialist_info_link
    #column :current_sign_in_at
    #column :last_sign_in_at
    #column :sign_in_count
  end

  show do
    render partial: 'user'
  end
  form partial: 'form'
end
