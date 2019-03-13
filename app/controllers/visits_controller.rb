class VisitsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @visit = Visit.new(property_id: params[:property_id], tenant_id: current_tenant.id, status_id: 1)
    @visit.save 

    customer = Stripe::Customer.create({
    source: 'tok_mastercard',
    email: 'paying.user@example.com',
    })

    if customer.save 
      current_tenant.update(stripe_customer_id: customer.id)
      flash[:success] = "Votre visite est bien enregistrée !"
      puts '*'*50
      puts customer.id
      puts '*'*50
      redirect_to root_path
    else       
      puts '*'*50
      puts customer.id
      puts '*'*50
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_property_visit_path
  end

  def show
  end

end
