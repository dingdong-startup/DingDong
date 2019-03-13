class ChargesController < ApplicationController
  def index
    @tenants = Tenant.all
  end

  def show 
    @tenant = Tenant.find(params[:id])
  end

  def new
  end

  def create
    @tenant = Tenant.last

    charge = Stripe::Charge.create({
    amount: 9900,
    currency: 'eur',
    customer: @tenant.stripe_customer_id,
    })

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
