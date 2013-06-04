class Message < ActiveRecord::Base
  has_paper_trail
  has_one :moderation_info, as: :moderable
  belongs_to :recipient, polymorphic: true
  belongs_to :sender, class_name: 'User'
  #belongs_to :text, class_name: 'ModerableText'

  scope :by_user, ->(user_id){ where("(messages.recipient_type = 'user' AND messages.recipient_id = ?) OR messages.sender_id = ?", user_id, user_id) }
  scope :received_by_user, ->(user_id){ where(recipient_id: user_id) }
  scope :sent_by_user, ->(user_id){ where(sender_id: user_id) }

  #accepts_nested_attributes_for :text
end