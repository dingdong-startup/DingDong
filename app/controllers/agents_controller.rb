class AgentsController < ApplicationController
  def create
  end

  def edit
  end

  def update
  end


  private

  def property_params
    params.require(:agent).permit(:first_name, :last_name, :email, :cellphone, :agency_id, :position_id)
  end

end
