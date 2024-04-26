class CountryInformation < ApplicationRecord

  def self.search_country_information(country_name)
    CountryInformation.where('country_name LIKE ?', country_name).first || fetch_country_information(country_name)
  end

  private

  def self.fetch_country_information(text)
    data = FetchCountryInformation.new(text).call

    if data.present?
      country_name = data.dig('name', 'common')

      CountryInformation.create(country_name: country_name, original_response: data)
    end
  end
end
