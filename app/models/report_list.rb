class ReportList < ApplicationRecord
  has_many :sold_report_lists
  has_many :sold_items, through: :sold_report_lists
  validates :name, presence: true
end
