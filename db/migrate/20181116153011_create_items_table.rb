# frozen_string_literal: true

class CreateItemsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :amount
      t.float :value
      t.string :donor, default: "Anônimo"
      t.string :receiver
      t.string :internal
      t.datetime :entry_date
      t.datetime :departure_date
      t.boolean :used, default: false
      t.boolean :lost, default: false

      t.timestamps
    end
  end
end