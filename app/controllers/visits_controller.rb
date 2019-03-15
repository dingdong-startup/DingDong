class VisitsController < ApplicationController
  def create
<<<<<<< HEAD
    visit = Visit.new(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 3)
    visit.save
=======
    visit = Visit.new(property_id: params[:property_id], tenant: current_tenant, visit_status_id: 2)
>>>>>>> dev

    customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email: params[:stripeEmail],
    })

    if customer.save
      current_tenant.update(stripe_customer_id: customer.id, payment_status_id: 2)
      flash[:success] = "Votre carte a bien été enregistrée !"
<<<<<<< HEAD
      visit.update(visit_status_id: 4)
=======
>>>>>>> dev
      redirect_to properties_path
    else
      flash[:danger] = "Une erreur s'est produite. Veuillez réessayer"
      redirect_to properties_path
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to properties_path
  end
end
