class VisitsController < ApplicationController
  def create
    
    @property = Property.find(params[:property_id])
    # testing if a visit exists or not
    @visit = current_tenant.existant_visit(@property)
    unless @visit.nil?
      @visit.update_attributes(visit_status_id: 3)
    else
      @visit = Visit.create(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 3)
    end
    #Testing if the user as already  adn successfully put its card
    if current_tenant.payment_status_id != 2 #in case it doesnt

      customer = Stripe::Customer.create({
        source: params[:stripeToken],
        email: params[:stripeEmail],
      })
          
      # if the stripe process is success, saving stripe customer id
      # updating payment status to 2
      # unfav if fav exists
      if customer.save
        current_tenant.update(stripe_customer_id: customer.id, payment_status_id: 2, phone_number: params[:tenant][:last_name])
        @visit.update(visit_status_id: 4)
        flash[:success] = "Carte bien enregistrée, demande de visite envoyée !"
        redirect_back(fallback_location: properties_path)
      else
        flash[:danger] = "Une erreur s'est produite. Veuillez réessayer"
        redirect_back(fallback_location: properties_path)
      end
    else #in case it does
      @visit.update(visit_status_id: 4)
      flash[:success] = "Ta demande a bien été enregistrée!"
      redirect_back(fallback_location: properties_path)
    end 
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_back(fallback_location: properties_path)
  end

  def update 
    if visit_is_canceled 
      @visit.destroy
      flash[:light] = "Demande de visite annulée"
      redirect_back(fallback_location: properties_path)
    end
  end

  private 

  def visit_is_canceled
    @visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 4) 
  end
end
