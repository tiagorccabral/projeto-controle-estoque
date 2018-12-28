class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :inventory_categories
  has_many :inventory_items, through: :inventory_categories
end
