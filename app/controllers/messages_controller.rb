class MessagesController < InheritedResources::Base
  # TODO: !!! set cancan and use load_and_authorize_resource to load only accepted messages

  before_filter :authenticate_user!
  #load_and_authorize_resource :specialist
  #load_and_authorize_resource :message, through: :specialist, shallow: true
  #load_and_authorize_resource :message
  belongs_to :specialist, :specialist_group, :order, optional: true, polymorphic: true

  respond_to :json, only: [:create, :index, :show_messages, :show_attachments]

  before_filter :check_have_recipient, only: [:new, :create]
  before_filter :select_accepted, only: [:index]

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
        executor = parent.executor
        executor_name = executor && executor.to_s || I18n.t('orders.executor_not_assigned')
        executor_avatar_url = executor && executor.avatar || Photo.new.photo.avatar_size.url
        render json: {msgs_text: messages_text,
                      executor_name: executor_name,
                      executor_avatar_url: executor_avatar_url,
                      attachment_previews_text: attachment_previews_text,
                      attached_to_name: parent.to_s
                    }
      }
    end
  end
  def show_attachments
    render json: { attachment_previews_text: attachment_previews_text }
  end
  def show_messages
    render json: { msgs_text: messages_text }
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
  def attachment_previews_text
    render_to_string(partial: 'attachments/attachments_in_chat',
                    locals: { attachments: parent.attachments,
                              unfinished_attachments: parent.unfinished_attachments},
                    layout: false, formats: [:html], handlers: [:haml])
  end
  def messages_text
    render_to_string(partial: 'messages/message_in_chat',
                    collection: collection.ordered_by_date, as: :message,
                    layout: false, formats: [:html], handlers: [:haml])
  end

  def select_accepted
    @messages = collection.accepted_or_self
  end
end
