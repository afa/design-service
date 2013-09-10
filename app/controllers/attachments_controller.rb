class AttachmentsController < InheritedResources::Base
  belongs_to :order, :plan_development, :replanning_endorsement, :engineering_system, :selected_form, optional: true #, polymorphic: true
  before_filter :authenticate_user!
  before_filter :check_permission, only: [:show, :download]
  before_filter :set_user, only: [:create]
  before_filter :check_can_destroy, only: [:destroy]

  respond_to :json, only: [:index, :create, :destroy]

  def show
    send_file resource.path, filename: resource.original_filename, type: resource.content_type, disposition: 'inline'
  end

  def download
    send_file resource.path, filename: resource.original_filename
  end

private

  def permitted_params
    params.permit(:attachment => [:file, :kind, :_destroy])
  end
  def check_permission
    if resource.authorized?(current_or_guest_user)
      true
    else
      render text: I18n.t('http_status.unauthorized'), status: :unauthorized
    end
  end

  def check_can_destroy
    if resource.user == User.current
      true
    else
      render text: I18n.t('http_status.unauthorized'), status: :unauthorized
    end
  end

  def set_user
    build_resource
    resource.user = current_or_guest_user
  end
end
