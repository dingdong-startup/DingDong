class TenantsController < ApplicationController

  before_action :authenticate_tenant!
  before_action :is_current_tenant?, only: [:show, :edit, :update]

  def show
  	@tenant = Tenant.find(params[:id])
  	@fav_properties = @tenant.fav_properties
  	@visit_properties = @tenant.requested_visits
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
   params.require(:tenant).permit(:first_name, :last_name, :email, :avatar, :documents)
  end

  def is_current_tenant?
    if params[:id]
      tenant = Tenant.find(params[:id])
      if tenant != current_tenant
        redirect_to tenant_path(current_tenant.id)
      end
    end
  end


end
