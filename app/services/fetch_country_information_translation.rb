# frozen_string_literal: true

class FetchCountryInformationTranslation
  API_URL = 'https://api.cognitive.microsofttranslator.com/translate'

  def initialize(country_information, language)
    @country_information = country_information
    @language = language
  end

  def call
    response = conn.post do |req|
      req.body = [body].to_json
    end

    JSON.parse(response.body)[0].dig('translations')[0]['text']
  end

  private

  def conn
    Faraday.new(
      url: API_URL,
      headers:,
      params:
    )
  end

  def params
    {
      'api-version' => '3.0',
      'to' => @language
    }
  end

  def body
    {
      'text' => @country_information.information
    }
  end

  def headers
    {
      'Ocp-Apim-Subscription-Key' => ENV['MICROSOFT_TRANSLATOR_API_KEY'],
      'Content-type' => 'application/json',
      'X-ClientTraceId' => SecureRandom.uuid,
      'Ocp-Apim-Subscription-Region' => 'eastus'
    }
  end
end
