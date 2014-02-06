# coding: utf-8
class AddSentToModeratorAtToOrder < ActiveRecord::Migration
  def change
   change_table :orders do |t|
    t.datetime :sent_to_moderator_at
   end
  end
end
