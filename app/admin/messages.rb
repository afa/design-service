# coding: utf-8
ActiveAdmin.register Message do
  decorate_with MessageDecorator
  controller do
    def permitted_params
      params.permit(message: [:text])
    end
    protected :permitted_params
  end
  show do
    render partial: 'message', locals: {message: resource}
  end
  form do |f|
    f.inputs 'Текст сообщения' do
      f.input :text
    end
    f.actions
  end
end
