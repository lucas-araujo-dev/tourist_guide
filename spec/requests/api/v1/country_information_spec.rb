require 'swagger_helper'

RSpec.describe 'Api::V1::CountryInformations', type: :request do
  path '/api/v1/country_informations/search_country' do
    get 'Searches country information' do
      tags 'CountryInformations'
      produces 'application/json'
      parameter name: 'country_name', in: :query, type: :string

      let(:country_information) { create(:country_information, country_name: 'Brazil') }
      let(:country_name) { country_information.country_name }

      response '200', 'Country information found' do
        run_test!
      end

      response '404', 'Country information not found' do
        let(:country_name) { 'not_found' }
        run_test!
      end
    end
  end
end
