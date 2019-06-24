class PaymentsController < ApplicationController
  def create
    customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email: params[:stripeEmail],
    })

    if customer.save
      flash[:success] = "Carte bien enregistrée, merci pour votre confiance !"
      redirect_to thank_you_path
    else
      flash[:alert] = "Un problème est survenue"
      redirect_to payments_path
    end
  end

  def thank_you

  end
end
