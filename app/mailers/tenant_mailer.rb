class TenantMailer < ApplicationMailer

  def new_visit_email(tenant, property)
  	@tenant = tenant
  	@property = property
  	mail(to: @tenant.email, subject: "Ding Dong! Ta demande de visite a bien été enregistrée")
  end
  	
end
