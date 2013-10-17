ActiveAdmin.register User do
  menu label: -> { I18n.t 'titles.users' }
  decorate_with UserDecorator


  controller do
    has_scope :by_role, :as => :role, :default => "specialist", only: [:index]
    def permitted_params
      params.permit(user: [:role, :email, :profile => [:name]])
    end
    custom_actions :resource => [:group_remove, :group_add]
    def group_add
     if params[:group]
      gr = SpecialistGroup.where(:id => params[:group]).first
      if gr
       resource.specialist.specialist_groups << gr unless resource.specialist.specialist_groups.include?(gr)
      end
      resource.save
     end
     render :json => {:group_form => render_to_string(:partial => 'admin/users/spec_groups.html.haml', :locals => {:resource => resource})}
    end
    def group_remove
     if params[:group]
      gr = SpecialistGroup.where(:id => params[:group]).first
      if gr
       resource.specialist.specialist_groups.delete(gr) if resource.specialist.specialist_groups.include?(gr)
      end
      resource.save
     end
     render :json => {:group_form => render_to_string(:partial => 'admin/users/spec_groups.html.haml', :locals => {:resource => resource})}
    end
  end

  table_columns = lambda do |tab|
   tab.instance_eval do
    Rails.logger.info "---admres #{@role}"
    if @role
    #if (defined?(resource) && resource.try(:specialist?)) || params[:role].nil? || params[:role] == 'specialist'
     column 'Номер ID', :sortable => :id do |u|
      link_to u.id.to_s, admin_user_path(u)
     end
     column 'ФИО', :sortable => :name do |u|
      u.full_name
     end
     column "Логин", :username
     column "Специальность" do |u|
      (u.specialist.try(:specializations) || []).map(&:title)
     end
     column 'Статус' do |u|
      u.specialist ? u.specialist.orders.where(:work_state => [:in_work, :client_agreed]).count > 0 ? 'Занят' : 'Свободен' : ''
     end
     column "Группа", :sortable => :specialist_groups do |u|
      u.specialist ? u.specialist.specialist_groups.map(&:name) : []
     end
     column 'Е-Майл', :email
     column "Телефон", :phone
     column "Дата регистрации", :created_at
    else
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
  end
  index do |f|
    @role = params[:role] ? params[:role] == 'specialist' : true
    span do
      div link_to('Зарегистрированные специалисты', admin_users_path(role: 'specialist'))
      div link_to('Зарегистрированные пользователи', admin_users_path(role: 'client'))
    end
    table_columns.call(self)
  end

  show do
    @role = resource.specialist?
    table_for [resource] do
      table_columns.call(self)
    end
    transactions = TransactionDecorator.decorate_collection((resource.transactions_in + resource.transactions_out).sort_by{|t| t.created_at })
    render partial: 'user', :locals => {:transactions => transactions}
  end
  form partial: 'form'
end
