class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
	end

	def after_sign_in_path_for(resource)
		if current_agency
  		agency_path(current_agency) 
  	else
  		root_path
  	end
	end

end
