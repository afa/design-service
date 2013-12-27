# coding: utf-8
class ChangeDefaultStateEmptyDraftMigratedata < ActiveRecord::Migration
  def change
    Order.where(work_state: 'empty_draft').update_all(work_state: 'draft')
  end
end
