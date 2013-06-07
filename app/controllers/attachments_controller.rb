class AttachmentsController < InheritedResources::Base
  def new
  end

  def create
    render text: request.env['rack.input'].string #"body: #{request.body.read}\nparams: #{params.inspect}\nenv: #{env.inspect}"
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  end
end
