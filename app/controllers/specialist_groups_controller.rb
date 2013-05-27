class SpecialistGroupsController < InheritedResources::Base
  load_and_authorize_resource
private
  def collection
    get_collection_ivar || set_collection_ivar(SpecialistGroupDecorator.decorate(end_of_association_chain))
  end
  def resource
    get_resource_ivar || set_resource_ivar(super.decorate)
  end
end
