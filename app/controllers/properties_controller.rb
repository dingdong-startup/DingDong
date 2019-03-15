class PropertiesController < ApplicationController
  def index 
    tenant = Tenant.find(params[:tenant_id])
    if tenant
      @visits = tenant.visits
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
      redirect_to root_path
    else
    flash[:danger] = @property.errors.messages
    redirect_to new_agency_property_path
    end
  end

  private

  def property_params
  	params.require(:property).permit(:title, :price, :surface, :description, :floor, :room, :available_date, :address)
  end


end
