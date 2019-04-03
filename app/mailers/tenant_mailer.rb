class TenantMailer < ApplicationMailer

  def new_visit_email(tenant, property)
  	@tenant = tenant
  	@property = property
  	mail(to: @tenant.email, subject: "Ding Dong! Votre demande de visite a bien été enregistrée")
  end

  def payment_email(tenant, property)
    @tenant = tenant
    @property = property
    mail(to: @tenant.email, subject: "Ding Dong! Votre empreinte bancaire a bien été enregistré")
  end

end
