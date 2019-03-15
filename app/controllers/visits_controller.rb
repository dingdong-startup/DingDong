class VisitsController < ApplicationController
  def create

    visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant)
    
    if visit 
      visit.update_attributes(visit_status_id: 3)
    else
      visit = Visit.new(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 3)
      visit.save
    end

    customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email: params[:stripeEmail],
    })

    if customer.save
      current_tenant.update(stripe_customer_id: customer.id, payment_status_id: 2)
      flash[:success] = "Votre carte a bien été enregistrée !"
      visit.update(visit_status_id: 4)
      redirect_to properties_path
    else
      flash[:danger] = "Une erreur s'est produite. Veuillez réessayer"
      redirect_to properties_path
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to properties_path
  end

  def update 
    if is_favorited 
      @visit.update_attributes(visit_status_id: 1)
      flash[:success] = "Appartement ajouté aux favoris !"
      redirect_to properties_path
    elsif is_unfavorited 
      @visit.update_attributes(visit_status_id: 2)
      flash[:primary] = "Appartement retiré des favoris !"
      redirect_to properties_path
    else
      Visit.create(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 2)
      flash[:success] = "Appartement ajouté aux favoris !"
      redirect_to properties_path
    end
  end

  private 

  def is_favorited
    @visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 2) 
  end

  def is_unfavorited 
    @visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 1)
  end
end
