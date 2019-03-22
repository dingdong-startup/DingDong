class AdminChargesController < ApplicationController
  def index
    @tenants = Tenant.where(payment_status_id: 2)
    puts @tenants
  end

  def create
    stripe_customer_id = params[:stripe_customer_id]
    puts stripe_customer_id
    puts "*"*60
    puts "Je suis en passe de marcher"
    tenant = Tenant.last
    charge = Stripe::Charge.create({
      amount: 9900,
      currency: 'eur',
      customer: stripe_customer_id,
    })
    puts "c'est BON"
    if charge.save 
      flash[:success] = "L'utilisateur a bien été débitée !"
      redirect_to root_path
    else
      flash[:danger] = "Erreur, réessayer"
      redirect_to root_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charge_index_path
  end
end
