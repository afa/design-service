# coding: utf-8
class RemoveLikesTable < ActiveRecord::Migration
  def change
    drop_table :likes
    drop_table :specialist_likes
  end
end
