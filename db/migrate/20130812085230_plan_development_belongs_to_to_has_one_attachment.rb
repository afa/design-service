class PlanDevelopmentBelongsToToHasOneAttachment < ActiveRecord::Migration
  def change
    PlanDevelopment.find_each do |pd|
      attachment = pd.attachment
      attachment.attachable = pd
      attachment.save
    end
    remove_column :plan_developments, :attachment_id
  end
end
