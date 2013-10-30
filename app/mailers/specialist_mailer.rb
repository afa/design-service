class SpecialistMailer < ActionMailer::Base
  default from: SITE_EMAIL

  def new_order(u, order)
    @text = I18n.t(:"mail.specialist.new_order")

    mail to: u.email
  end

  def payment(u, purchase)
    @text = I18n.t(:"mail.specialist.payment")

    mail to: u.email
  end

  def group_added(u, group)
   @text = I18n.t(:"mail.specialist.group_added")
    mail to: u.email
  end

  def group_removed(u, group)
   @text = I18n.t(:"mail.specialist.group_removed")
    mail to: u.email
  end
  def message_arrived(u, message)
   @text = I18n.t(:"mail.specialist.message_arrived")
   mail to: u.email
  end
end
