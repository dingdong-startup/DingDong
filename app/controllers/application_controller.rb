class ApplicationController < ActionController::Base



rescue_from CanCan::AccessDenied do |exception|
		respond_to do |format|
			format.html { 
				flash[:danger] = exception.message
				redirect_to root_path
			}
		end
	end	

end
