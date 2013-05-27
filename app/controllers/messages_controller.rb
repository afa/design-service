class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource :specialist
  load_and_authorize_resource :message, through: :specialist, shallow: true
  belongs_to :specialist, :specialist_group, optional: true, polymorphic: true

  def new
    recipient = User.find(params[:recipient_id])
    redirect_to :back, alert: 'You should select recipient of a message'  unless recipient
    @message = Message.new
    @message.to = recipient
    @message.build_text
  end

  def create
    @message = Message.new(permitted_params)
    @message.from = current_user
    if @message.save
      redirect_to @message
    else
      render action: 'new'
    end
  end

private
  def permitted_params
    params.permit(message: [:to_id, text_attributes: [:text]])
  end
  #def begin_of_association_chain
  #  current_or_guest_user
  #end
end