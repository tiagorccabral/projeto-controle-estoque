class InventoryItem < ApplicationRecord
  validates :code, uniqueness: true
end
