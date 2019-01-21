class CreateBackofficeReportLists < ActiveRecord::Migration[5.2]
  def change
    create_table :report_lists do |t|
      t.string :name
      t.date :from_date
      t.date :to_date

      t.timestamps
    end

    create_table :sold_report_lists do |t|
      t.belongs_to :report_lists, index: true
      t.belongs_to :sold_items, index: true

      t.timestamps
    end
  end
end
