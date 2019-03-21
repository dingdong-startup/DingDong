class TenantMailer < ApplicationMailer
  def welcome_email(user)
    mail(from: "maxime@startoop.fr", to: "mlesegret@yopmail.com",
         subject: "This is a nice welcome email")
  end
end
