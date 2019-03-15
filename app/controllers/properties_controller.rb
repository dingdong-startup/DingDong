class PropertiesController < ApplicationController
  def index 
    
    @tenant = nil

    if params[:tenant_id]
      @tenant =Tenant.find(params[:tenant_id])
      @fav_visits = Visit.where(visit_status_id: 2, tenant_id: @tenant.id)
      @asked_visits = Visit.where(visit_status_id: 4, tenant_id: @tenant.id)

    end
    @properties = Property.all
  end
  
  def show
    @property = Property.find(params[:id])
  end
  
  def new
  	@agency = Agency.find(params[:agency_id])
    @property = Property.new
  end

  def create
  	@property = Property.new(property_params)
    @property.images.attach(params[:property][:images])
    @property.agency_id = params[:agency_id]
    @property.agent_id = 1
    @property.area_id = 1

    if @property.save
      flash[:success] = "Votre bien a été créé"
      redirect_to agency_path(current_agency)
    else
    flash[:danger] = @property.errors.messages
    redirect_to new_agency_property_path
    end
  end

  def update
    @property = Property.update(property_params)

    if @property.save
      flash[:success] = "Votre bien a été créé"
      redirect_to agency_path(current_agency)
    else
    flash[:danger] = @property.errors.messages
    redirect_to new_agency_property_path
    end
  end


  def destroy
    @property = Property.find(params[:property_id])
    if @property.destroy
      flash[:success] = "Votre bien a été supprimé"
      redirect_to agency_path(current_agency)
    else
      flash[:danger] = @property.errors.messages
      redirect_to agency_path(current_agency)
    end
  end

  private

  def property_params
  	params.require(:property).permit(:title, :price, :surface, :description, :floor, :room, :available_date, :address)
  end


end
