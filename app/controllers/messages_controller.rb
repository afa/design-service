class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!
  #load_and_authorize_resource :specialist
  #load_and_authorize_resource :message, through: :specialist, shallow: true
  load_and_authorize_resource :message
  belongs_to :specialist, :specialist_group, optional: true, polymorphic: true

  respond_to :json, only: [:create]

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
      #msg.recipient = parent.
    end
    create! { resource }
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
