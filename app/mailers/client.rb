class Client < ActionMailer::Base
  default from: SITE_EMAIL

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client.payment_failed.subject
  #
  def payment_failed(u, purchase)
    @text = I18n.t(:"mailer.client.payment_failed")

    mail to: "#{u.email}"
  end
  def payment_success(u, purchase)
   @text = I18n.t(:"mailer.client.payment_success")
   mail to: u.email
  end
  def message_arrived(u, message)
   @text = I18n.t(:"mail.specialist.message_arrived")
   mail to: u.email
  end
end
