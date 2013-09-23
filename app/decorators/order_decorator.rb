class OrderDecorator < Draper::Decorator
  decorates_association :orderable
  decorates_association :messages

  delegate_all
  def to_s
    h.link_to source.title, h.admin_order_path(source)
  end
  def client_info
    client.try{|c| c.decorate.admin_link }
  end
  def orderable_info
    if source.orderable
      h.link_to  source.title, h.url_for([:admin,source.orderable])
    end
  end
  def executors_info
    h.link_to  'Исполнители', h.admin_specialists_path(order: source.id)
  end

  def time_to_finish
    source.completion_time ? h.distance_of_time_in_words(Time.now, source.completion_time) : I18n.t('order.completion_time.not_set')
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def border_class
    orderable.border_class
  end

  def border_class_mild
    orderable.border_class_mild
  end

  def completion_time
    source.completion_time && I18n.l(source.completion_time)
  end

  def work_state
    I18n.t "order.work_state.#{source.work_state}"
  end
end
