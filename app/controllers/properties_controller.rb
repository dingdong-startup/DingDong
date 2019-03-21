class PropertiesController < ApplicationController

  alias_method :current_user, :current_tenant

  #load_and_authorize_resource

  def index

    if params[:tenant_id]
      @tenant =Tenant.find(params[:tenant_id])
      @fav_visits = Visit.where(visit_status_id: 2, tenant_id: @tenant.id)
      @asked_visits = Visit.where(visit_status_id: 4, tenant_id: @tenant.id)
    end

    @properties = Property.all
    
    # Selecting all favorites so I can find it for the favorite update method
    #@favorites = Favorite.all
    @favorite = Favorite.new

    @last_property = Property.last
    @last_date = ((Time.now - @last_property.created_at)/60/60/24).to_i



  end

  def show
    @properties = Property.all
    @property = Property.find(params[:id])
    @areas = Area.all
    @asked_visits = @property.visits.where(visit_status_id: 4)
    ##TODO : Fix this bug, the params for agency ID works for agencies/id/property/id, but not for propertie/id
    # @agency = Agency.find(params[:agency_id])
    @favorite = Favorite.find_by(property_id: @property.id, tenant: current_tenant)
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
    puts params
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
