# coding: utf-8
class AddAttachmentToPlanDevelopments < ActiveRecord::Migration
  def change
  	change_table :plan_developments do |t|
      t.references :attachment
    end
  end
end
