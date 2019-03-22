class Visit < ApplicationRecord

	after_save :new_visit_email_send

  belongs_to :tenant
  belongs_to :property
  belongs_to :visit_status   

 	def new_visit_email_send
  	TenantMailer.new_visit_email(self.tenant, self.property).deliver_now
  end


end
