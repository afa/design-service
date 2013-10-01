ActiveAdmin.register SpecialistGroup do
  controller do
    def permitted_params
      params.permit(specialist_group: {portfolio_ids: [], specialist_ids: []})
    end
    private :permitted_params
  end
  show do
    render template: 'admin/specialist_groups/show'
  end
end
