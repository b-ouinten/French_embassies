class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :code_1
      t.string :code_2
      t.string :code_3
      t.string :fr_title
      t.string :en_title

      t.timestamps
    end
  end
end
