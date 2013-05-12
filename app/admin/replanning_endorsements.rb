ActiveAdmin.register ReplanningEndorsement do
  menu label: ->(){ I18n.t('replanning_endorsements.title') }
  config.filters = false

  decorate_with ReplanningEndorsementDecorator

  index do
    column :id
    default_actions
    column :client
    column :developed_by_general_projector
    column :flat_area
    column :replanning_organization_licensed

    column :created_at
    column :updated_at
  end

  form partial: 'form'
  show do
    render 'replanning_endorsement'
  end

  controller do
    def permitted_params
      params.permit(replanning_endorsement: [:price])
    end
  end  
end
