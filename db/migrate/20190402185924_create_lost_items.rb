class CreateLostItems < ActiveRecord::Migration[5.2]
  def change
    create_table :lost_items do |t|
      t.string :name
      t.integer :code
      t.float :value
      t.integer :status

      t.timestamps
    end
  end
end
