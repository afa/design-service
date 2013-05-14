ActiveAdmin.register Specialist do
  decorate_with SpecialistDecorator
  controller do
    has_scope :executors_by_order, as: 'order_executors', only: [:index]
    def permitted_params
      params.permit()
    end
  end
  show do
    render partial: 'specialist'
  end
end
