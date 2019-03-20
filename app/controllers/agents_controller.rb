class AgentsController < ApplicationController
  def create
  end

  def edit
  end

  def update

    @agent = Agent.find(params[:id])
    puts "#"*100
    puts params
    puts "#"*100

    if @agent.update(property_params)
      flash[:success] = "Les informations de l'agent ont été mises à jour"
      redirect_to agency_path(@agent.agency)
    else
      flash[:danger] = @agent.errors.messages
      redirect_to agency_path(@agent.agency)
    end

  end


  private

  def property_params
    params.require(:agent).permit(:first_name, :last_name, :email, :cellphone, :agency_id, :position_id)
  end

end