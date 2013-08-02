class Moderation < ActiveRecord::Base
  belongs_to :moderable, polymorphic: true
  def accepted?
    accepted_final || accepted_first_stage &&  updated_at < Time.now - 45.minutes
  end
end
