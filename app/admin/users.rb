ActiveAdmin.register User do
  decorate_with UserDecorator

  controller do
    has_scope :by_role, :as => :role, :default => "specialist", only: [:index]
    def permitted_params
      params.permit(user: [:role])
    end
  end

  index do |f|
    span do
      div link_to('Зарегистрированные специалисты', admin_users_path(role: 'specialist'))
      div link_to('Зарегистрированные пользователи', admin_users_path(role: 'client'))
    end
    default_actions
    if params[:role].nil? || params[:role] == 'specialist'
     column 'Номер ID', :id
     column 'ФИО', :sortable => :name do |u|
      u.full_name
     end
     column "Логин", :username
     column "Специальность" do |u|
      u.specialist.specialization.try(:title)
     end
     column 'Статус' do |u|
      u.specialist.orders.where(:work_state => [:in_work, :client_agreed]).count > 0 ? 'Занят' : 'Свободен'
     end
     column "Группа", :sortable => :specialist_groups do |u|
      u.specialist.specialist_groups.map(&:name)
     end
     column 'Е-Майл', :email
     column "Телефон", :phone
     column "Дата регистрации", :created_at
    else
     column 'Номер ID', :id
     column 'ФИО', :sortable => :name do |u|
      u.full_name
     end
     column "Логин", :username
     column 'Е-Майл', :email
     column "Телефон", :phone
     column 'Заказы' do |u|
      "<div>#{u.orders.map{|o| link_to(o.orderable.class.name, admin_order_path(o.id)).html_safe }.join("</div><div>").html_safe}</div>".html_safe
     end
     column "Дата регистрации", :created_at
    end
  end

  show do
    render partial: 'user'
  end
  form partial: 'form'
end
