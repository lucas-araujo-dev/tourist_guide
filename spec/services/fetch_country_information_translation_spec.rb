require 'rails_helper'
require 'faraday'

RSpec.describe FetchCountryInformationTranslation, type: :service do
  describe '#call' do
    let(:text) { 'Hello' }
    let(:language) { 'es' }
    let(:translation_service) { FetchCountryInformationTranslation.new(text, language) }
    let(:conn) do
      Faraday.new(url: 'url', headers: { example: 'example1' }, params: { 'api-version' => '3.0', 'to' => language })
    end

    context 'when the API call is successful' do
      before do
        allow(Faraday).to receive(:new).and_return(conn)
        allow(conn).to receive(:post).and_return(double(success?: true,
                                                        body: [{ 'translations' => [{ 'text' => 'Ola' }] }].to_json))
      end
      it 'returns the translated text' do
        result = translation_service.call

        expect(result).to eq('Ola')
      end
    end

    context 'when the API call fails' do
      it 'returns nil' do
        allow(Faraday).to receive(:get).and_return(double(success?: false))

        result = translation_service.call

        expect(result).to be_nil
      end
    end
  end
end
