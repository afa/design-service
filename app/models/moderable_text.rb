class ModerableText < ActiveRecord::Base
  attr_accessible :moderated_text, :original_text, :verified
  attr_accessible :text

  validates :original_text, presence: true
  validates :original_text, immutable: true
  def text=(value)
    self.original_text = value if new_record?
    self.moderated_text = value
  end
  def text
    self.moderated_text
  end
end
