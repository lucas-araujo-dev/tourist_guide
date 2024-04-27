# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryInformation, type: :model do
  describe '.search' do
    let(:country_name) { 'Brazil' }

    context 'when country information is found in the database' do
      let!(:country_information) { create(:country_information, country_name:) }

      it 'returns the country information from the database' do
        result = CountryInformation.search(country_name)

        expect(result).to eq(country_information.information)
      end
    end

    context 'when country information is not found in the database' do
      before do
        allow(FetchCountryInformation).to receive(:new).and_return(double(call:
                                                                            {
                                                                              'name' => 'Brazil',
                                                                              'capital' => 'Brasília',
                                                                              'population' => 211_000_000,
                                                                              'area' => 8_515_767,
                                                                              'currencies' => { 'BRL' => { 'name' => 'Brazilian real' } },
                                                                              'languages' => { 'pt' => 'Portuguese' },
                                                                              'flags' => { 'alt' => 'https://restcountries.com/data/bra.svg' }
                                                                            }))
      end
      it 'fetches the country information from the API and saves it to the database' do
        result = CountryInformation.search(country_name)

        expect(result).to eq(CountryInformation.last.information)
      end
    end
  end

  describe '.fetch_translation' do
    let(:country_information) { create(:country_information) }
    let(:language) { 'es' }

    context 'when translation is found in the database' do
      let!(:country_information_translation) do
        create(:country_information_translation, country_information:, language:)
      end

      it 'returns the translation from the database' do
        result = CountryInformation.fetch_translation(country_information, language)

        expect(result).to eq(country_information_translation.translation)
      end
    end

    context 'when translation is not found in the database' do
      before do
        allow(FetchCountryInformationTranslation).to receive(:new).and_return(double(call: 'Hola'))
      end

      it 'fetches the translation from the API and saves it to the database' do
        result = CountryInformation.fetch_translation(country_information, language)

        expect(result).to eq(CountryInformationTranslation.last.translation)
      end
    end
  end

  describe '.normalize_information' do
    let(:data) do
      {
        'name' => { 'common' => 'Brazil' },
        'region' => 'South America',
        'capital' => ['Brasília'],
        'population' => 206_135_893,
        'area' => 8_515_767,
        'currencies' => { 'BRL' => { 'name' => 'Brazilian real' } },
        'languages' => { 'pt' => 'Portuguese' },
        'flags' => { 'alt' => 'https://restcountries.com/data/bra.svg' }
      }
    end

    it 'returns the country information' do
      result = CountryInformation.normalize_information(data)

      expect(result).to eq('Brazil is a country in South America. Its capital is Brasília. The population is 206135893. The area is 8515767 square kilometers. The currency is Brazilian real. The language is Portuguese. The flag: https://restcountries.com/data/bra.svg.')
    end
  end
end
