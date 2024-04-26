# frozen_string_literal: true

class FetchCountryInformation
  API_URL = 'https://restcountries.com/v3.1'

  def initialize(country_name)
    @country_name = country_name
  end

  def call
    response = Faraday.get("#{API_URL}/name/#{@country_name}")
    response.success? ? JSON.parse(response.body).first : nil
  end
end
