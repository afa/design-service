class AttachmentsController < InheritedResources::Base
  belongs_to :order, optional: true #, polymorphic: true

  before_filter :load_attachment, except: [:index]
  before_filter :check_permission, except: [:index]

  respond_to :json, only: [:index]

  def show
    send_file @attachment.path, filename: @attachment.original_filename, type: @attachment.content_type, disposition: 'inline'
  end

  def download
    send_file @attachment.path, filename: @attachment.original_filename
  end

  def index
    respond_with do |format|
      format.json{ render json: {attachment_ids: collection.pluck(:id) } }
    end
  end

private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end

  def check_permission
    if @attachment.authorized?(current_or_guest_user)
      true
    else
      render text: I18n.t('http_status.unauthorized'), status: :unauthorized
    end
  end
end
