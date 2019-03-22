class PropertiesController < ApplicationController

  

  def index
    @properties = Property.all
    @last_property = Property.last
    @last_date = ((Time.now - @last_property.created_at)/60/60/24).to_i

    @tenant = current_tenant
    @asked_visits = @tenant.requested_visits

    @favorite = Favorite.new


  end

  def show
    @properties = Property.all
    @property = Property.find(params[:id])

    @areas = Area.all
    @tenant = current_tenant

    @favorite = @tenant.fav_properties
    @asked_visits = @tenant.requested_visits

    @agency = @property.agency
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
    @property.area = Area.find_by(name: params[:area])


    if @property.save
      flash[:success] = "Votre bien a été créé"
      redirect_to agency_path(current_agency)
    else
      flash[:danger] = @property.errors.messages
      redirect_to new_agency_property_path
    end
  end

  def edit

  end

  def update
    @property = Property.find(params[:id])
    @agency = Agency.find(params[:agency_id])

    if @property.update(agency_property_params)
      flash[:success] = "Votre bien a été mis à jour"
      redirect_to agency_property_path(@agency,@property)
    else
      flash[:danger] = @property.errors.messages
      redirect_to agency_property_path(@agency,@property)
    end
  end


  def destroy
    @property = Property.find(params[:property_id])
    if @property.update(is_archived: true)
      flash[:success] = "Votre bien a été archivé"
      redirect_to agency_path(current_agency)
    else
      flash[:danger] = @property.errors.messages
      redirect_to agency_path(current_agency)
    end
  end



  private

  def agency_property_params
    params.require("/agencies/#{@agency.id}/properties/#{@property.id}").permit(:title, :price, :surface, :description, :floor, :room, :available_date, :address, :charges, :agency_fees, :deposit, :furnished)
  end

  def property_params
  	params.require(:property).permit(:title, :price, :surface, :description, :floor, :room, :available_date, :address, :charges, :agency_fees, :deposit, :furnished)
  end
end
