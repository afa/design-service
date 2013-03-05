class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :floor
      t.string :section

      t.timestamps
    end
  end
end
