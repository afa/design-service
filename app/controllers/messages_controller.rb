class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @message.build_text
  end

  def create
    @message = Message.new(params[:message])
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