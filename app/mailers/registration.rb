class Registration < ActionMailer::Base
  default from: SITE_EMAIL
  def registered(u)
   @text = I18n.t(:"mail.registration.registered")
   mail to: "#{u.email}"
  end

  def fast_registered(u)
   @text = I18n.t(:"mail.registration.fast_registered")
   mail to: "#{u.email}"
  end
end
