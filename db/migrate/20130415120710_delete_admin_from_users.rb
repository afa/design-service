# coding: utf-8
class DeleteAdminFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :admin
    end
  end
end
