class AttachmentsController < ApplicationController
  before_filter :load_attachment
  before_filter :check_permission

  def show
    send_file @attachment.path, filename: @attachment.original_filename, type: @attachment.content_type, disposition: 'inline'
  end

  def download
    send_file @attachment.path, filename: @attachment.original_filename
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
