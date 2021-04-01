class FrenchEmbassy < ApplicationRecord
  # Associations
  belongs_to :country, optional: true
end
