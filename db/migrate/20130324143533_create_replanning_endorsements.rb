class CreateReplanningEndorsements < ActiveRecord::Migration
  def change
    create_table :replanning_endorsements do |t|
      t.boolean :developed_by_general_projector
      t.boolean :replanning_organization_licenzed
      t.decimal :flat_area, :precision => 5, :scale => 1

      t.timestamps
    end
  end
end
