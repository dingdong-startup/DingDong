class AgencyMailer < ApplicationMailer


  def welcome_email(agency)
    @agency = agency
    @url  = 'http://dingdongproduction.herokuapp.com/agencies/sign_up'
    @url_password = 'http://dingdongproduction.herokuapp.com/agencies/password/edit'
    subject = 'Bienvenue chez Ding Dong !'
    # gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
    # gibbon.lists
    merge_vars = {
      "EMAIL" => @agency.email,
    }
    body = mandrill_template("Welcome_agent", merge_vars)
    send_mail(@agency.email, subject, body)
  end
end
