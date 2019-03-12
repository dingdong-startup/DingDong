class AgenciesController < ApplicationController
  def index
  end

  def show
    @agency = Agency.find(params[:id])
  end
end
