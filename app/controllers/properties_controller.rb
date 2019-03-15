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
    @agency = Agency.find(params[:agency_id])
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

  def edit
    @property = Property.find(params[:id])
    @agency = Agency.find(params[:agency_id])
  end

  def update
    @property = Property.find(params[:id])
    @agency = Agency.find(params[:agency_id])
    puts "*"*60
puts params
puts params["/agencies/#{@agency.id}/properties/#{@property.id}"]
    if @property.update(agency_property_params)
      flash[:success] = "Votre bien a été mis à jour"
      redirect_to agency_property_path(@agency,@property)
    else
      flash[:danger] = @property.errors.messages
      redirect_to agency_property_path(@agency,@property)
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @agency = Agency.find(params[:agency_id])
    if @property.delete
      flash[:success] = "Votre propriété a bien été supprimée"
      redirect_to root_path
    else
      flash[:danger] = @property.errors.messages
      redirect_to new_agency_property_path
    end
  end


  private
  def agency_property_params
    params.require("/agencies/#{@agency.id}/properties/#{@property.id}").permit(:title, :price, :surface, :description, :floor, :room, :available_date, :address)

  end

  def property_params
    params.require(:property).permit(:title, :price, :surface, :description, :floor, :room, :available_date, :address)
  end


end
