class PropertiesController < ApplicationController
  def show
    @property = Property.find(params[:id])
  end

  def create
  	puts params
  	@property = Property.find(params[:id])
  end
end
