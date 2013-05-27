class SpecialistGroupsController < InheritedResources::Base
  has_scope :by_specialization, as: :specialization, only: [:index]
  load_and_authorize_resource
  before_filter :decorate_collection, only: :index
  before_filter :decorate_resource, except: :index
private
  def decorate_collection
    set_collection_ivar( SpecialistGroupDecorator.decorate(get_collection_ivar) )
  end
  def decorate_resource
    set_resource_ivar( SpecialistGroupDecorator.decorate(get_resource_ivar) )
  end
end
