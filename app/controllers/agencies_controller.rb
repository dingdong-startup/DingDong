class AgenciesController < ApplicationController

  alias_method :current_user, :current_tenant

  before_action :authenticate_agency!
  before_action :is_current_agency?, only: [:show, :edit, :update]
  
  #load_and_authorize_resource

  def index
  	@agencies = Agency.all
  end

  def show
  	@agency = Agency.find(params[:id])
  	@properties = @agency.available_properties
    @property = Property.new

  	@director = @agency.agents.find_by(position_id: 1)
  	@agent = @agency.agents.find_by(position_id: 2)

    @areas = Area.all

  end

  def is_current_agency?
    if Agency.find(params[:id]) != current_agency
      redirect_to agency_path(current_agency.id)
    end
  end

end
