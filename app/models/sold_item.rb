class SoldItem < ApplicationRecord
  has_many :sold_report_lists
  has_many :report_lists, through: :sold_report_lists
end
