class TenantsController < ApplicationController
  def show
  	@tenant = Tenant.find(params[:id])
  	#To change once relationship between tenant and property would have been done
  	@fav_properties = Property.all.limit(14)
  	#To change to all flats where the user asked for a visit
  	@visit_properties = Property.all.limit(3)
  end

  def edit
  end

  def update
		@tenant = Tenant.find(params['id'])

		if @tenant.update(tenant_params)
			flash[:success] = "Tes informations ont été mises à jour"
		else
			 flash[:danger] = []
	    @tenant.errors.full_messages.each do |message|
	      flash[:danger] << message
	    end
	    flash[:danger] = flash[:danger].join(" & ")
		end 

		redirect_to tenant_path(@tenant.id)

  end

  private

  def tenant_params
  	params.require(:tenant).permit(:first_name, :last_name, :email, :avatar)
  end

end
