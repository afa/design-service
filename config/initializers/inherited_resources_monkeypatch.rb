# inherited_resources 0.4.0 use respond_to? without second argument(true) which makes it impossible to use private method permitted_params

module InheritedResources
  module BaseHelpers  
    # extract attributes from params
    def build_resource_params
      parameters = respond_to?(:permitted_params, true) ? permitted_params : params
      rparams = [parameters[resource_request_name] || parameters[resource_instance_name] || {}]
      if without_protection_given?
        rparams << without_protection
      else
        rparams << as_role if role_given?
      end

      rparams
    end  
  end
end
