# coding: utf-8
class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|

      t.timestamps
    end
  end
end
