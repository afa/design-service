class OrderDecorator < Draper::Decorator
  delegate_all
  def client_info
    client.try{|c| c.decorate.admin_link }
  end
  def orderable_info
    if source.orderable
      h.link_to  source.orderable.class.model_name.underscore.humanize, h.url_for([:admin,source])
    end
  end
  def executors_info
    h.link_to  'Исполнители', h.admin_specialists_path(order: source.id)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
