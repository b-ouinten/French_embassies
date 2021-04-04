class AddFrTitleNormalizedToCountryTable < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :fr_title_normalized, :string
  end
end
