class AddProfileIdToClients < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.references :profile
    end
  end
end
