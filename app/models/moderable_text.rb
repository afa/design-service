class ModerableText < ActiveRecord::Base
  #attr_accessible :moderated_text, :original_text, :verified, :rejected
  attr_accessible :text, :first_line, :second_line

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
  
  attr_reader :first_line, :second_line
  def first_line=(value)
    @first_line = value
    set_composed_text
  end
  def second_line=(value)
    @second_line = value
    set_composed_text
  end
  def set_composed_text
    self.text = "#{first_line} #{second_line}"
  end
end
