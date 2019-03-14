class VisitsController < ApplicationController
  def create
    @visit = Visit.create(property_id: params[property_id], tenant: current_tenant, visit_status_id: 1)

    customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email: params[:stripeEmail],
    })

    if customer.save
      current_tenant.update(stripe_customer_id: customer.id)
      flash[:success] = "Votre carte a bien été enregistrée !"
      redirect_to :back
    else
      flash[:danger] = "Une erreur s'est produite. Veuillez réessayer"
      redirect_to :back
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end
end
