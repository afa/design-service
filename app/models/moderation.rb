class Moderation < ActiveRecord::Base
  belongs_to :moderable, polymorphic: true
end
