class PropertiesController < ApplicationController
  def show
    @property = Property.find_by(agency_id: params[:agency_id])
    puts @property.title
  end
end
