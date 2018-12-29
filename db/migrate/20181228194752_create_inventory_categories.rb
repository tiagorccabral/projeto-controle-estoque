class CreateInventoryCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_categories do |t|
      t.belongs_to :inventory_item, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
