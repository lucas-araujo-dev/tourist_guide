require 'rails_helper'

RSpec.describe 'Api::V1::CountryInformations', type: :request do
  describe 'GET /search_country' do
    let!(:country_information) { create(:country_information, country_name: 'Brazil') }
    let(:params) { { country_name: country_information.country_name } }
    let(:do_request) { get api_v1_country_informations_search_country_path, params: }

    context 'when returns http success' do
      it do
        do_request
        expect(response).to have_http_status(:success)
      end
    end

    context 'returns not_found(404)' do
      let(:params) { { text: 'not_found' } }

      it do
        do_request
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
