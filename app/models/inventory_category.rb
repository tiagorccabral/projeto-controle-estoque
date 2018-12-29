class InventoryCategory < ApplicationRecord
  belongs_to :inventory_item
  belongs_to :category
end
