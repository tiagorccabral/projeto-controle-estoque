class CreateSoldItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sold_items do |t|
      t.string :name
      t.integer :code
      t.float :value
      t.integer :amount

      t.timestamps
    end
  end
end
