class VisitsController < ApplicationController
  def create
    
    visit = Visit.find_by(property_id: params[:property_id], tenant: current_tenant)

    if visit 
      # Si existe parce que le Tenant a déjà mis en favoris, on l'update en visist status : Demanded Visit
      visit.update_attributes(visit_status_id: 3)
    else
      # Si visite n'existe pas parce que le user n'a pas mis en favoris, je crée une visite avec visit status : Demanded Visit
      visit = Visit.new(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 3)
      visit.save
    end
    
    # Stripe prend la releve sur l'étape de création de l'object Customer
    customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email: params[:stripeEmail],
    })

    if customer.save
      # Si la création du Stripe Customer est ok, le payment status s'update en 2, card saved
      current_tenant.update(stripe_customer_id: customer.id, payment_status_id: 2)
      flash[:success] = "Votre carte a bien été enregistrée !"
      # Et le visit status s'update en 4, visite accepted
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
      flash[:primary] = "Demande de visite annulée"
      redirect_back(fallback_location: properties_path)
    else
      puts "*" * 60
      puts "C'est moi!!!!"
      puts params
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
