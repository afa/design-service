class AttachmentsController < ApplicationController
  before_filter :load_attachment
  before_filter :check_permission

  def show
    content_type = @attachment.file.tap{|f| f.set_content_type}.file.content_type
    send_file @attachment.file.file.file, :type => content_type, :disposition => 'inline', filename: @attachment.file.file.original_filename
  end

  def download
    send_file @attachment.file.file.file, filename: @attachment.file.file.original_filename
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
