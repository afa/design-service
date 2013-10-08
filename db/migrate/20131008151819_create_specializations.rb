class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :group_title
      t.timestamps
    end
  end
end
