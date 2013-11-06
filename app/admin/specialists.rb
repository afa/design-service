ActiveAdmin.register Specialist do
  decorate_with SpecialistDecorator
  menu label: -> { I18n.t 'titles.specialists' }
  controller do
    has_scope :by_order, as: 'order', only: [:index]
    def permitted_params
      params.permit(:specialist => [user: [:role, :email, :profile => [:name, :surname, :middle_name]]])
    end
    custom_actions :resource => [:group_remove, :group_add]
    def group_add
     if params[:group]
      gr = SpecialistGroup.where(:id => params[:group]).first
      if gr
       unless resource.specialist_groups.include?(gr)
        resource.specialist_groups << gr
        SpecialistMailer.group_added(resource, gr).deliver
       end
      end
      resource.save
     end
     render :json => {:group_form => render_to_string(:partial => 'admin/specialists/spec_groups.html.haml', :locals => {:resource => resource})}
    end
    def group_remove
     if params[:group]
      gr = SpecialistGroup.where(:id => params[:group]).first
      if gr
       if resource.specialist_groups.include?(gr)
        resource.specialist_groups.delete(gr)
        SpecialistMailer.group_removed(resource, gr).deliver
       end
      end
      resource.save
     end
     render :json => {:group_form => render_to_string(:partial => 'admin/specialists/spec_groups.html.haml', :locals => {:resource => resource})}
    end
  end
  table_columns = lambda do |tab|
   tab.instance_eval do
    column 'Номер ID', :sortable => :id do |u|
     link_to u.id.to_s, admin_specialist_path(u)
    end
    column 'ФИО' do |u|
     u.user.full_name
    end
    column "Логин" do |u|
     u.user.username
    end
    column "Специальность" do |u|
     u.specializations.map(&:title)
    end
    column "Статус" do |u|
     u.orders.where(:work_state => [:in_work, :client_agreed]).exists? ? 'Занят' : 'Свободен'
    end
    column "Группа" do |u|
     u.specialist_groups.map(&:name)
    end
    column "Е-Майл" do |u|
     u.user.email
    end
    column "Телефон" do |u|
     u.user.phone
    end
    column "Дата регистрации" do |u|
     u.user.created_at
    end
   end
  end
  index do |f|
   table_columns.call(self)
  end
  show do
    render partial: 'specialist'
  end
end
