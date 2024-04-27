class CountryInformation < ApplicationRecord
  has_many :country_information_translations, dependent: :destroy

  def self.search(country_name, language = nil)
    country_information = CountryInformation.find_by('country_name LIKE ?', country_name) || fetch_country_information(country_name)
    return unless country_information

    language.present? ? fetch_translation(country_information, language) : country_information.information
  end

  def self.fetch_country_information(text)
    data = FetchCountryInformation.new(text).call
    return unless data

    information = normalize_information(data)
    CountryInformation.create(information: information)
  end

  def self.fetch_translation(country_information, language)
    translation = country_information.country_information_translations.find_by(language: language)

    return translation.translation if translation

    translation = FetchCountryInformationTranslation.new(country_information.information, language).call

    country_information.country_information_translations.create(translation: translation, language: language)

    translation
  end

  def self.normalize_information(data)
    "#{data['name']['common']} is a country in #{data['region']}. Its capital is #{data['capital'].first}." \
      " The population is #{data['population']}." \
      " The area is #{data['area']} square kilometers." \
      " The currency is #{data['currencies'].values.first['name']}." \
      " The language is #{data['languages'].values.first}." \
      " The flag: #{data.dig('flags', 'alt')}."
  end
end
