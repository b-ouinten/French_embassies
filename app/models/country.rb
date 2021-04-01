class Country < ApplicationRecord
  # Associations
  has_one :french_embassy, dependent: :destroy
  has_many :french_foreigners_countings, dependent: :destroy
end
