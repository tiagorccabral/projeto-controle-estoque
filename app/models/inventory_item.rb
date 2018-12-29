class InventoryItem < ApplicationRecord
  validates :code, uniqueness: true
  has_many :inventory_categories
  has_many :categories, through: :inventory_categories
end
