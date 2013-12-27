# coding: utf-8
class OrderDecorator < Draper::Decorator
  decorates_association :orderable
  decorates_association :messages

  delegate_all
  def to_s
    h.link_to source.title, h.admin_order_path(source)
  end
  def client_info
    source.client.try{|c| c.decorate.admin_link }
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
    source.completion_time ? h.distance_of_time_in_words(Time.now, source.completion_time) : 'Время завершения неизвестно'
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
  def price

    if User.current.specialist?
      # labor_participation = User.current.specialist.labor_participation || 1.0
      # if labor_participation
      #  source.price.to_f * labor_participation
      # else 
      #  source.price
      # end
      source.specialist_price || source.money_for_specialist
    else
      source.price
    end

  end
  def work_state
    I18n.t "order.work_state.#{source.work_state}"
  end

  def admin_actions
    actions = []
    if source.sent_to_moderator?
      actions << 'Выставить цену и назначить специалиста'
    elsif source.specialist_disagreed?
      actions << 'Назначить нового специалиста'
    end
    actions << 'Контроль сообщений'  unless source.messages.to_be_moderated.empty?
    actions = ['Не требуется']  if actions.empty?
    actions.join("\n")
  end

  def admin_work_state
    if source.sent_to_moderator?
      source.executor.is_a?(SpecialistGroup) ? 'Новый для группы' : 'Новый'
    elsif source.specialist_disagreed?
      'Специалист отказался'
    else
      work_state
    end
  end

  def client
    source.client.guest? ? source.client.try(&:email) : source.client.to_s
  end
end
