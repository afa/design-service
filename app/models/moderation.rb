class Moderation < ActiveRecord::Base
  belongs_to :moderable, polymorphic: true
  state_machine :status, initial: :not_accepted do
    state :not_accepted
    state :rejected_first_stage
    state :rejected_complete
    state :accepted_first_stage
    state :accepted_complete
    state :accepted_automatically

    event :accept do
      transition all => :accepted_complete, :if => :main_moderator?
      transition [:not_accepted, :accepted_first_stage] => :accepted_first_stage, :if => :moderator?
    end
    event :auto_accept do
      transition :accepted_first_stage => :accepted_automatically, :if => :can_be_auto_accepted?
    end
    event :reject do
      transition all => :rejected_complete, :if  => :main_moderator?
      transition (all - [:accepted_complete, :rejected_complete]) => :rejected_first_stage, :if => :moderator?
    end
    after_transition all => [:accepted_complete, :accepted_automatically], :do => :send_mail
  end

  def accepted?
    accepted_complete? || accepted_automatically?
  end

  def rejected?
    rejected_first_stage? || rejected_complete?
  end

  def main_moderator?
    User.current.main_moderator?
  end

  def moderator?
    User.current.moderator?
  end

  def can_be_auto_accepted?
    accepted_first_stage? &&  updated_at < Time.now - 45.minutes
  end

  # TODO: fix bug when message sent before executor was set, message recipient is nil (messages are not rebinded to executor on executor setup or update, 
  #  possibly we should take info about sender/recipient from order itself, possibly message shouldn't have sender/recipient at all, only boolean flag client/ececutor.
  # But such realization can suffer from lack of specialist-specialist interactons)
  def send_mail
    if moderable.is_a?(Message)
      if moderable.recipient && moderable.recipient.specialist?
        SpecialistMailer.message_arrived(moderable.recipient).deliver
      elsif moderable.recipient && moderable.recipient.client?
        Client.message_arrived(moderable.recipient).deliver
      end
    end
  end
end
