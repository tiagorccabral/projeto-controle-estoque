class LostItem < ApplicationRecord
  enum status: [:stolen, :deterioration, :donation, :other]
end
