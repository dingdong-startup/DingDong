class AgencyMailer < ApplicationMailer
  default from: 'no-reply@ding-dong.fr'

  def welcome_email(agency)
    @agency = agency
    @url  = 'http://dingdongproduction.herokuapp.com/agencies/sign_up'
    @url_password = 'http://dingdongproduction.herokuapp.com/agencies/password/edit'
    mail(to: @agency.email, subject: 'Bienvenue chez Ding Dong !', from_name: 'Ding Dong')
    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
    gibbon.lists
  end

  def mandrill_template(template_name, attributes)
   mandrill = Mandrill::API.new(ENV["SMTP_PASSWORD"])

   merge_vars = attributes.map do |key, value|
     { name: key, content: value }
   end

   mandrill.templates.render(template_name, [], merge_vars)["html"]
 end

end
