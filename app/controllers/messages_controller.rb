class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @messages = Message.all
  end

  def new
    recipient = User.find(params[:recipient_id])
    redirect_to :back, alert: 'You should select recipient of a message'  unless recipient
    @message = Message.new
    @message.to = recipient
    @message.build_text
  end

  def create
    @message = Message.new(params[:message])
    @message.from = current_user
    if @message.save
      redirect_to @message
    else
      render action: 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to @message
    else
      render action: 'edit'
    end
  end
end