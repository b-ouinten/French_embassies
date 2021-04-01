class CreateFrenchEmbassies < ActiveRecord::Migration[5.2]
  def change
    create_table :french_embassies do |t|
      t.string :country_title
      t.float :latitude
      t.float :longitude
      t.string :coordinates

      t.belongs_to :country, index: true

      t.timestamps
    end
  end
end
