class AgenciesController < ApplicationController

  alias_method :current_user, :current_tenant
  
  #load_and_authorize_resource

  def index
  	@agencies = Agency.available_properties
  end

  def show
  	@agency = current_agency
  	@properties = @agency.available_properties
    @property = Property.new

  	@director = @agency.agents.find_by(position_id: 1)
  	@agent = @agency.agents.find_by(position_id: 2)

    @areas = Area.all

  end



end
