#encoding: utf-8
class PlanDevelopment < ActiveRecord::Base
  include ActsAsOrderable

  before_validation do
   if flat_area_changed? || num_plans_changed?
    order.calculated_price = nil
    unless order.id.nil?
     order.update_attribute :calculated_price, nil
    end
   end
  end

  extend Enumerize
  enumerize :num_guests, in: [:zero, :less_than_five, :five_to_fifteen, :greater_than_fifteen]
  enumerize :big_kitchen, in: [:less_than_fifteen, :greater_than_fifteen]
  enumerize :num_plans, in: [1,2,3,4]

  def attachment_kinds
    ['plan_of_flat']
  end

  def full_address; "#{address} (подъезд: #{section}, этаж: #{floor})"; end

  def family_composition_first_line; @family_composition_first_line ||= family_composition; end
  def family_composition_second_line; @family_composition_second_line ||= ''; end

  def mk_family_composition; self.family_composition = [@family_composition_first_line, @family_composition_second_line].compact.reject(&:blank?).join(' '); end

  def family_composition_first_line=(val); @family_composition_first_line = val; mk_family_composition; end
  def family_composition_second_line=(val); @family_composition_second_line = val; mk_family_composition; end

  def self.default_params
    { join_kitchen_with_living_room: true,
      big_kitchen: :greater_than_fifteen,
      cloakroom_needed: true,
      cabinet_needed: true,
      num_guests: :zero,
      washing_room_needed: true,
      num_plans: 1 }
  end

  def locate_price
   return price if price? && price > 0.0
   plans = PlanDevelopment.where(address: address, floor: floor, section: section, flat_area: flat_area, num_rooms: num_rooms, num_standpipes: num_standpipes, num_plans: num_plans).order("created_at desc").all.select{|o| o.price? && o.price > 0.0 } - [self]
   if plans.empty?
    default_price || 0.0
   else
    plans.first.price
   end
  end
end
