class SoldReportList < ApplicationRecord
  belongs_to :sold_item
  belongs_to :report_list
end
