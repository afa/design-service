class ClientsController < InheritedResources::Base
  respond_to :html
  load_and_authorize_resource
end
