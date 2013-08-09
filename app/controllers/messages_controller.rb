class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!
  #load_and_authorize_resource :specialist
  #load_and_authorize_resource :message, through: :specialist, shallow: true
  #load_and_authorize_resource :message
  belongs_to :specialist, :specialist_group, :order, optional: true, polymorphic: true

  respond_to :json, only: [:create, :index]

  before_filter :check_have_recipient, only: [:new, :create]

  def new
    @message = Message.new do |msg|
      msg.recipient = parent
      msg.build_text
    end
  end

  def create
    @message = Message.new(permitted_params[:message]) do |msg|
      msg.sender = current_user
      msg.attached_to = parent
      msg.recipient = parent.interlocutor(current_user)
    end
    create! { resource }
  end

  def index
    respond_with do |format|
      format.json {
        text = render_to_string(partial: 'messages/message_in_chat.html', collection: collection.ordered_by_date, as: :message, layout: false, handlers: [:haml])
        executor = parent.executor
        executor_name = executor && executor.to_s || I18n.t('orders.executor_not_assigned')
        executor_avatar_url = executor && executor.avatar || Photo.new.photo.avatar_size.url
        render json: {msgs_text: text,
                      executor_name: executor_name,
                      executor_avatar_url: executor_avatar_url
                    }
      }
    end
  end

private
  def permitted_params
    params.permit(message: [:text])
  end
  #def begin_of_association_chain
  #  current_or_guest_user
  #end
  def check_have_recipient
    redirect_to :back, alert: 'Невозможно создать сообщение в никуда'  unless parent
    false
  end
end
