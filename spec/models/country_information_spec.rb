# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryInformation, type: :model do
  describe '.search_country_information' do
    let(:country_name) { 'Brazil' }

    context 'when country information is found in the database' do
      let!(:country_information) { create(:country_information, country_name:) }

      it 'returns the country information from the database' do
        result = CountryInformation.search_country_information(country_name)

        expect(result).to eq(country_information)
      end
    end

    context 'when country information is not found in the database' do
      before do
        allow(FetchCountryInformation).to receive(:new).and_return(double(call: { 'name' => { 'common' => 'Brazil' } }))
      end
      it 'fetches the country information from the API and saves it to the database' do
        result = CountryInformation.search_country_information(country_name)

        expect(result).to eq(CountryInformation.last)
      end
    end
  end
end
