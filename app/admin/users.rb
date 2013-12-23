# coding: utf-8
ActiveAdmin.register User do
  menu label: -> { I18n.t 'titles.users' }
  decorate_with UserDecorator


  controller do
    has_scope :by_role, :as => :role, :default => "specialist", only: [:index]
    def permitted_params
      params.permit(user: [:role, :email, :profile => [:name, :surname, :middle_name]])
    end
  end

  table_columns = lambda do |tab|
   tab.instance_eval do
    Rails.logger.info "---admres #{@role}"
     column 'Номер ID', :sortable => :id do |u|
      link_to u.id.to_s, admin_user_path(u)
     end
     column 'ФИО', :sortable => :name do |u|
      u.full_name
     end
     column "Логин", :username
     column 'Е-Майл', :email
     column "Телефон", :phone
     column 'Заказы' do |u|
      "<div>#{u.orders.map{|o|link_to(o.title, [:admin, o.orderable]).html_safe }.join("</div><div>").html_safe}</div>".html_safe
     end
     column "Дата регистрации", :created_at

   end
  end
  index do |f|
    table_columns.call(self)
  end

  show do
    table_for [resource] do
      table_columns.call(self)
    end
    transactions = TransactionDecorator.decorate_collection((resource.transactions_in + resource.transactions_out).sort_by{|t| t.created_at })
    render partial: 'user', :locals => {:transactions => transactions}
  end
  form partial: 'form'
end
