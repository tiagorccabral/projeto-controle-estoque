class CreateInventoryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.string :code
      t.string :responsible
      t.string :area
      t.string :acquisition_mode
      t.string :conservation_state
      t.string :serial_number
      t.string :model
      t.string :storage_location
      t.integer :age, default: 0
      t.float :value, default: 0.0
      t.float :lifespan, default: 0.0
      t.float :current_value, default: 0.0
      t.float :depreciation, default: 0.0
      t.date :date_of_acquisition


      t.timestamps
    end
  end
end
