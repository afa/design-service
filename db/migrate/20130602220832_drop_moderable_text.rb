# coding: utf-8
class DropModerableText < ActiveRecord::Migration
  def change
    drop_table :moderable_texts
  end
end
