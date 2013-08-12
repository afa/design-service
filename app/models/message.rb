class Message < ActiveRecord::Base
  has_paper_trail
  has_one :moderation_info, as: :moderable
  delegate :accepted?, to: :moderation_info

  belongs_to :recipient, polymorphic: true
  belongs_to :sender, class_name: 'User'
  belongs_to :attached_to, polymorphic: true

  scope :by_user, ->(user_id){ where("(messages.recipient_type = 'user' AND messages.recipient_id = ?) OR messages.sender_id = ?", user_id, user_id) }
  scope :received_by_user, ->(user_id){ where(recipient_type: 'user', recipient_id: user_id) }
  scope :sent_by_user, ->(user_id){ where(sender_id: user_id) }
  scope :ordered_by_date, lambda{ order(:created_at) }
  def authorized_user?(user)
    #accepted? && (user == sender || user == recipient)
    user && (user == sender || user == recipient || user.moderator?)
  end
end
