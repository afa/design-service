# coding: utf-8
ActiveAdmin.register Portfolio do
  controller do
    def permitted_params
      params.permit(portfolio: [:name, :description, :specialist_group_id])
    end
    protected :permitted_params
  end

  show do
    attributes_table do
      row :name
      row :description
      row :specialist
      row :specialist_group
    end
    render partial: 'shared/portfolio', locals: {portfolio_items: resource.portfolio_items, example_set: portfolio.id}
  end
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :specialist_group
      f.input :portfolio_items
    end
    f.actions

  end
 
end
