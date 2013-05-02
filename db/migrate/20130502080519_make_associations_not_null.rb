class MakeAssociationsNotNull < ActiveRecord::Migration
  def change
    # Make sure no null value exist
    PlanDevelopment.all.each do |plan_development|
      p plan_development
      plan_development.build_family_composition
      plan_development.build_comment
      plan_development.build_attachment
      plan_development.save
    end
    # Change the column to not allow null
    change_column :plan_developments, :family_composition_id, :integer, :null => false
    change_column :plan_developments, :comment_id, :integer, :null => false
    change_column :plan_developments, :attachment_id, :integer, :null => false
  end
end
