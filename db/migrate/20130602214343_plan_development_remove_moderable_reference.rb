class PlanDevelopmentRemoveModerableReference < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.remove :comment_id
      t.remove :family_composition_id
      t.text :comment_id
      t.text :family_composition_id
    end 
  end 
end
