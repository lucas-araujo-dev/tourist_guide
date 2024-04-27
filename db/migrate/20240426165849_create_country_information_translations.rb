# frozen_string_literal: true

class CreateCountryInformationTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :country_information_translations do |t|
      t.belongs_to :country_information, null: false, foreign_key: true
      t.string :language
      t.text :translation

      t.timestamps
    end
  end
end
