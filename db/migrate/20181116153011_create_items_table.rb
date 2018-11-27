# frozen_string_literal: true

class CreateItemsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :amount
      t.float :value
      t.float :value_sold, default: 0.0
      t.integer :total_sold, default: 0
      t.string :donor, default: "Anônimo"
      t.string :receiver
      t.boolean :internal, default: false
      t.datetime :entry_date
      t.datetime :departure_date
      t.boolean :used, default: false
      t.boolean :lost, default: false

      t.timestamps
    end
  end
end
