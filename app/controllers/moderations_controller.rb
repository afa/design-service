class ModerationsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :json

  def accept
    resource.accept
    resource.save!
  end

  def reject
    resource.reject
    resource.save!
  end

  def show
    respond_with do |format|
      format.json { render json: {text: moderation_form_text} }
    end
  end

protected
  def moderation_form_text
    render_to_string(partial: 'moderations/moderation', locals: {moderation: resource}, formats: [:html], handlers: [:haml], layout: false)
  end
end
