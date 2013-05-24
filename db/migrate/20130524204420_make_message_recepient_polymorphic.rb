class MakeMessageRecepientPolymorphic < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.remove :from_id
      t.references :sender
      t.remove :to_id
      t.references :recipient, polymorphic: true
    end
  end

end
