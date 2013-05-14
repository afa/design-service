ActiveAdmin.register Specialist do
  decorate_with SpecialistDecorator
  controller do
    has_scope :by_order, as: 'order', only: [:index]
    def permitted_params
      params.permit()
    end
  end
  show do
    render partial: 'specialist'
  end
end
