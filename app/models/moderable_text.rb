class ModerableText < ActiveRecord::Base
  attr_accessible :moderated_text, :original_text, :verified
end
