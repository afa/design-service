class SpecialistGroupsController < InheritedResources::Base
  has_scope :by_specialization, as: :specialization, only: [:index]
  load_and_authorize_resource
  before_filter :decorate_collection, only: :index
  before_filter :decorate_resource, except: :index
private
  def decorate_collection
    set_collection_ivar( SpecialistGroupDecorator.decorate_collection(get_collection_ivar) )
  end
  def decorate_resource
    set_resource_ivar( SpecialistGroupDecorator.decorate(get_resource_ivar) )
  end
  def page_subtitle
    if params[:action] == 'index'
      if !params[:specialization] || params[:specialization].match(/^all$/i)
        'Все специалисты'
      else
        I18n.t "specialists.#{params[:specialization].pluralize}.title"
      end
    else
      I18n.t "specialists.#{resource.specialization.name.pluralize}.title" rescue 'Специалисты'
    end
  end

  def page_subtitle_class
    'designers'

    # FIX ME -- code behind is absolutely correct but css understands only designers.
    # One should either remove this code and use in css and here .specialists class
    # or customize classes on each specialization basis
    #
    # specialist_group_specialization.try(&:pluralize)
  end

  def specialist_group_specialization
    if params[:action] == 'index'
      if !params[:specialization] || params[:specialization].match(/^all$/i)
        'specialist'
      else
        params[:specialization]
      end
    else
      resource.specialization.name
    end
  end

  helper_method :specialist_group_specialization

  def specialist_page_subtitle
    if params[:action] == 'show'
      render_to_string partial: 'specialist_groups/specialist/subtitle_with_avatar', locals: {specialist_group: resource}
    else
      super
    end
  end
end
