class RenameLicenzedToLicensedInPlanningEndorsements < ActiveRecord::Migration
  def change
    change_table :replanning_endorsements do |t|
      t.rename :replanning_organization_licenzed, :replanning_organization_licensed
    end
  end
end
