class FloorPlan < ActiveRecord::Base
  belongs_to :selected_form
  def self.by_id(floorpan)
    where(selected_form_id: floor_plan)
  end
end
