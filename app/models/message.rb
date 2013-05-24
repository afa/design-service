class Message < ActiveRecord::Base
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  belongs_to :text, class_name: 'ModerableText'

  scope :by_user, ->(user_id){ where('messages.from_id = ? OR messages.to_id = ?', user_id, user_id) }
  scope :received_by_user, ->(user_id){ where(to_id: user_id) }
  scope :sent_by_user, ->(user_id){ where(from_id: user_id) }

  accepts_nested_attributes_for :text
end