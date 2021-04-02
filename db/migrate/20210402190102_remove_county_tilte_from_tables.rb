class RemoveCountyTilteFromTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :french_embassies, :country_title, :string
    remove_column :french_foreigners_countings, :country_title, :string
  end
end
