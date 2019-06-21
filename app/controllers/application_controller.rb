class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :store_user_location!, if: :storable_location?
	after_action :store_action

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
	end

	def storable_location?
		request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
	end

	def store_user_location!
      # :user is the scope we are authenticating
		store_location_for(:user, request.fullpath)
	end

	def after_sign_in_path_for(resource)
		if current_agency
  		agency_path(current_agency) 
  	else
  		super
  	end
	end	

	# def after_sign_in_path_for(resource)
	# 	properties_path
	# end

  
  def store_action
    return unless request.get? 
    if (request.path != "/tenants/sign_in" &&
        request.path != "/tenants/sign_up" &&
        request.path != "/tenants/password/new" &&
        request.path != "/tenants/password/edit" &&
        request.path != "/tenants/confirmation" &&
        request.path != "/tenants/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:tenant, request.fullpath)
    end
  end

end
