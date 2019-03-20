class VisitsController < ApplicationController
  def create
    
    visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant)

    if visit 
      # If Visit exist because the Tenant already put a property in its favorites, we update the visit status to Demanded Visit
      visit.update_attributes(visit_status_id: 3)
    else
      # If the visist doesn't exist yet because the user didn't put one in its favorites, we create a visist with VisitStatus : Demanded Visit
      visit = Visit.new(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 3)
      visit.save
    end
    
    # Stripe take the lead on the creation Customer step
    customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email: params[:stripeEmail],
    })

    if customer.save
      # If the Stripe Customer object creation is ok, the paymentstatus is updated to 2 : Card Saved
      current_tenant.update(stripe_customer_id: customer.id, payment_status_id: 2)
      flash[:success] = "Votre carte a bien été enregistrée !"
      # TODO : Make model's method, it's not DRY at all
      if visit.property.favorites.find_by(tenant: current_tenant)
        visit.property.favorites.find_by(tenant: current_tenant).update_attributes(is_liked: false)
      end
      # The visit status is updated to 4 : Visit Accepted
      visit.update(visit_status_id: 4)
      redirect_back(fallback_location: properties_path)
    else
      flash[:danger] = "Une erreur s'est produite. Veuillez réessayer"
      redirect_back(fallback_location: properties_path)
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_back(fallback_location: properties_path)
  end

  def update 
    if is_favorited 
      @visit.update_attributes(visit_status_id: 1)
      flash[:success] = "Appartement ajouté aux favoris !"
      redirect_back(fallback_location: properties_path)
    elsif is_unfavorited 
      @visit.update_attributes(visit_status_id: 2)
      flash[:primary] = "Appartement retiré des favoris !"
      redirect_back(fallback_location: properties_path)
    elsif visit_is_canceled 
      @visit.update_attributes(visit_status_id: 1)
      @visit.property.favorites.find_by(tenant: current_tenant).update_attributes(is_liked: true)
      @visit.destroy
      flash[:primary] = "Demande de visite annulée"
      redirect_back(fallback_location: properties_path)
    else
      Visit.create(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 2)
      flash[:success] = "Appartement ajouté aux favoris !"
      redirect_back(fallback_location: properties_path)
    end
  end

  private 

  def visit_is_canceled
    @visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 4) 
  end

  def is_favorited
    @visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 2) 
  end

  def is_unfavorited 
    @visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 1)
  end
end
