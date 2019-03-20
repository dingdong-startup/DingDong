class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
	end


	rescue_from CanCan::AccessDenied do |exception|
		respond_to do |format|
			format.html { 
				flash[:danger] = exception.message
				redirect_to root_path
			}
		end
	end	

end
