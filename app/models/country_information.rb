class CountryInformation < ApplicationRecord
  has_many :country_information_translations, dependent: :destroy

  def self.search(country_name, language)
    country_information = search_country_information(country_name)

    if language.present? && country_information.present?
      search_translation(country_information, language)
    else
      country_information
    end
  end

  def self.search_country_information(country_name)
    CountryInformation.where('country_name LIKE ?', country_name).first || fetch_country_information(country_name)
  end

  def self.fetch_country_information(text)
    data = FetchCountryInformation.new(text).call

    return unless data.present?

    create_country_information(data)
  end

  def self.create_country_information(data)
    information = fetch_information(data)

    CountryInformation.create(information:)
  end

  def self.search_translation(country_information, language)
    country_information.country_information_translations.where(language:).first || fetch_translation(
      country_information, language
    )
  end

  def self.fetch_translation(country_information, language)
    translation = FetchCountryInformationTranslation.new(country_information.information, language).call

    return unless translation.present?

    country_information.country_information_translations.create(translation:, language:)
  end

  def self.fetch_information(data)
    "#{data['name']['common']} is a country in #{data['region']}. Its capital is #{data['capital'].first}." \
      " The population is #{data['population']}." \
      " The area is #{data['area']} square kilometers." \
      " The currency is #{data['currencies'].values.first['name']}." \
      " The language is #{data['languages'].values.first}." \
      " The flag: #{data.dig('flags', 'alt')}."
  end
end
