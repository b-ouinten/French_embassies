class CreateFrenchForeignersCountings < ActiveRecord::Migration[5.2]
  def change
    create_table :french_foreigners_countings do |t|
      t.string :country_title
      t.string :year
      t.integer :number_of_foreigners

      t.belongs_to :country, index: true

      t.timestamps
    end
  end
end
