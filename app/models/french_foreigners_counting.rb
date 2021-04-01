class FrenchForeignersCounting < ApplicationRecord
    # Associations
    belongs_to :country, optional: true
end
