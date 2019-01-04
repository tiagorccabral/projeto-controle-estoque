class Item < ApplicationRecord

  validates :name, presence: true
  validates :amount, presence: true
  validates :value, presence: true, numericality: {greater_than: 0}
  validates :donor, presence: false
  validates :receiver, presence: false
  validates :internal, presence: false
end
