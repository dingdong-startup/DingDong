class AgenciesController < ApplicationController

  alias_method :current_user, :current_tenant
  #load_and_authorize_resource

  def index
  	@agencies = Agency.all
  end

  def show
  	@agency = Agency.find(params[:id])
  	@properties = @agency.properties
    @property = Property.new
  	#@director = @agency.agents
    #@agent = @agency.agents
    @areas = Area.all
  end
end
