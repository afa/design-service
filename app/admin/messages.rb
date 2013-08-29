ActiveAdmin.register Message do
  decorate_with MessageDecorator
  show do
    render partial: 'message', locals: {message: resource}
  end
end
