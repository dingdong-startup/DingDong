class TenantMailer < ApplicationMailer
  def welcome_email(tenant)
    @tenant = tenant
    mail(to: @tenant.email, subject: "Ding Dong! Vous allez bientôt trouver l'appartement de vos rêves")
  end
end
