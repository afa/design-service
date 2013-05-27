# to be included into controller (but that controller should have #resource method that acts like that of InheritedResources) 
# and must be authenticable (only authenticated users can do this)
module LikeableResource
  extend ActiveSupport::Concern
  included do
    #custom_actions resource: [:upvote_like, :downvote_like, :toggle_like]  # For some reasons it prevents normal work of json responses
    respond_to :json, only: [:upvote_like, :downvote_like, :toggle_like]
    before_filter :authenticate_user!, only: [:upvote_like, :downvote_like, :toggle_like]
  end

  def toggle_like
    resource.toggle_like_from(current_user)
    respond_to do |format|
      format.json { render json: { toggle_like_text: resource.toggle_like_text_for(current_user) } }
    end
  end

  def upvote_like  
    resource.set_like_from(current_user)
    respond_to do |format|
      format.json { render(json: { completed: true }) }
    end
  end
  
  def downvote_like
    resource.delete_like_from(current_user)
    respond_to do |format|
      format.json { render(json: { completed: true }) }
    end
  end
end