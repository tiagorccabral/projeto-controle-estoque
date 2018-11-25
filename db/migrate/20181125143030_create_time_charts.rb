class CreateTimeCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :time_charts do |t|
      t.string :name
      t.integer :amount_donated
      t.float :value_donated
      t.datetime :report_date

      t.timestamps
    end
  end
end
