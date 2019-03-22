class AgenciesController < ApplicationController


  before_action :authenticate_agency!
  before_action :is_current_agency?, only: [:show, :edit, :update]
  

  def index
  	@agencies = Agency.all
  end

  def show
  	@agency = Agency.find(params[:id])
  	@properties = @agency.available_properties
    @director = @agency.agents.find_by(position_id: 1)
    @agent = @agency.agents.find_by(position_id: 2)
    @property = Property.new
    @areas = Area.all
  end

  # This method test if the agency is trying to access to an other agency profile page and redirect him to his own profile page if it is
  def is_current_agency?
    if Agency.find(params[:id]) != current_agency
      redirect_to agency_path(current_agency.id)
    end
  end

end
