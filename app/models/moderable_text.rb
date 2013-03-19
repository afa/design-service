class ModerableText < ActiveRecord::Base
  #attr_accessible :moderated_text, :original_text, :verified, :rejected
  attr_accessible :text

  validates :text, presence: true
  validates :original_text, immutable: true
  
  def text=(value)
    self.original_text = value if new_record?
    self.moderated_text = value
  end
  def text
    self.moderated_text
  end
  
  def accepted?
    !rejected && verified
  end
end
