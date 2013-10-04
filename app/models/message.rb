class Message < ActiveRecord::Base
  before_create :build_moderation_info
  has_paper_trail
  has_one :moderation_info, as: :moderable, class_name: 'Moderation'
  delegate :accepted?, :rejected?, to: :moderation_info

  belongs_to :recipient, polymorphic: true
  belongs_to :sender, class_name: 'User'
  belongs_to :attached_to, polymorphic: true

  scope :by_user, ->(user_id){ where("(messages.recipient_type = 'user' AND messages.recipient_id = ?) OR messages.sender_id = ?", user_id, user_id) }
  scope :received_by_user, ->(user_id){ where(recipient_type: 'user', recipient_id: user_id) }
  scope :sent_by_user, ->(user_id){ where(sender_id: user_id) }
  scope :ordered_by_date, lambda{ order('"messages"."created_at"') }
  # scope :accepted, ->{ joins(:moderation_info).where(moderations: {status: [:accepted_complete, :accepted_automatically]}) }
  # scope :to_be_shown, ->(user_id){ ###accepted or sent### }
  scope :accepted_or_self, ->{ includes(:moderation_info).where('"moderations"."status" IN(\'accepted_complete\',\'accepted_automatically\') OR "messages"."sender_id" = :user_id', user_id: User.current.id) }

  def authorized_user?(user)
    # accepted? && (user == sender || user == recipient)
    user && (user == sender || user == recipient.user || user.moderator?)
  end
end
