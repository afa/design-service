ActiveAdmin.register EngineeringSystem do
  menu label: ->(){ I18n.t('titles.engineering_system') }
  config.filters = false

  decorate_with EngineeringSystemDecorator

  # index do
    # column :id
    # default_actions
    # column :client
    # column :developed_by_general_projector
    # column :flat_area
    # column :replanning_organization_licensed

    # column :created_at
    # column :updated_at
  # end

  form partial: 'form'
  show do
    render 'engineering_system'
  end

  controller do
    def permitted_params
      params.permit(engineering_system: [:price])
    end
  end
end
