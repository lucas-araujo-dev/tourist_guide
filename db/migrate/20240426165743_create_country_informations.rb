class CreateCountryInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :country_informations do |t|
      t.string :country_name
      t.text :information

      t.timestamps
    end
  end
end
