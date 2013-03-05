class CreateModerableTexts < ActiveRecord::Migration
  def change
    create_table :moderable_texts do |t|
      t.text :original_text
      t.text :moderated_text
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
