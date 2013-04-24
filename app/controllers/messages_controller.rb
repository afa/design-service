class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!

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
    params.permit(message: [:to_id, text_attributes: [:text]] }
  end
end