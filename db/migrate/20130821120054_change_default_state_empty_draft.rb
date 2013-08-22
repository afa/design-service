class ChangeDefaultStateEmptyDraft < ActiveRecord::Migration
  def change
    change_column :orders, :work_state, :string, default: 'draft'
  end
end
