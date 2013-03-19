class AddRejectedFieldToModerableTexts < ActiveRecord::Migration
  def change
    add_column :moderable_texts, :rejected, :boolean, default: false
  end
end
