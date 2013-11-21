class Registration < ActionMailer::Base
  default from: SITE_EMAIL
  def registered(u)
   @text = I18n.t(:"mail.registration.registered")
   mail to: "#{u.email}"
  end

  def fast_registered(u)
   @text = I18n.t(:"mail.registration.fast_registered")
   p "---mail-user", u
   mail to: "#{u.email}"
  end

  def reset_password_instructions(record, token, opts = {})
   @user = record
   @token = token
   mail to: record.email
  end
end
